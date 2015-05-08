describe TestsController do
  context 'when requests SHOULD be documented' do
    it 'stores JSON requests in Avocado' do |example|
      get :json
      document(example) do
        expect(Avocado::Uploader.instance.payload.size).to eq 1
      end
    end
  end

  context 'when requests should NOT be documented' do
    it 'does not store non-JSON requests' do |example|
      get :text
      document(example) do
        expect(Avocado::Uploader.instance.payload).to be_empty
      end
    end

    it 'does not store when document: false', document: false do |example|
      get :json
      document(example) do
        expect(Avocado::Uploader.instance.payload).to be_empty
      end
    end

    it 'does not store when document_if returns false' do |example|
      Avocado.document_if = proc { false }
      get :json
      document(example) do
        expect(Avocado::Uploader.instance.payload).to be_empty
      end
    end
  end

  describe 'File uploads' do
    context 'when file is at the top level params hash' do
      it 'should show when files are uploaded' do |example|
        get :json, file: Rack::Test::UploadedFile.new(File.expand_path('../../fixtures/test.jpg', __FILE__), 'text/plain')
        document(example) do
          expect(payload[:request][:params]['file']).to eq '<Multipart File Upload>'
        end
      end
    end

    context 'when file is deeper within params hash' do
      it 'should show when files are uploaded' do |example|
        get :json, user: { avatar: Rack::Test::UploadedFile.new(File.expand_path('../../fixtures/test.jpg', __FILE__), 'text/plain') }
        document(example) do
          expect(payload[:request][:params]['user']['avatar']).to eq '<Multipart File Upload>'
        end
      end
    end
  end

  describe 'Payload' do

    context 'with params' do
      it 'should have sent the params' do |example|
        get :json, parameter: 123
        document(example) do
          expect(payload[:request][:params]).to eq Hash['parameter' => '123']
        end
      end
    end

    context 'with headers' do
      it 'should send the header' do |example|
        @request.headers['X-Example-Header'] = 123
        Avocado.headers = ['X-Example-Header']
        get :json, nil
        document(example) do
          expect(payload[:request][:headers]).to eq Hash['X-Example-Header' => 123]
        end
      end
    end

    context 'ignored params' do
      it 'should not contain ignored params that are concat' do |example|
        Avocado.ignored_params << 'parameter'
        get :json, parameter: 123
        document(example) do
          expect(payload[:request][:params]).to eq Hash.new
        end
      end
    end

    context 'includes example description' do
      it 'should have sent the description' do |example|
        get :json
        document(example) do
          expect(payload[:description]).to eq 'should have sent the description'
        end
      end
    end

  end

  def payload
    Avocado::Uploader.instance.payload.first
  end

end