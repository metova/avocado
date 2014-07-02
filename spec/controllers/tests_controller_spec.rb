describe TestsController do
  context 'when requests SHOULD be documented' do
    around do |example|
      Avocado.reset!
      expect { example.run }.to change { Avocado.payload.size }.from(0).to(1)
    end

    it 'stores JSON requests in Avocado' do
      get :json
    end
  end

  context 'when requests should NOT be documented' do
    around do |example|
      Avocado.reset!
      example.run
      Avocado.payload.should == []
    end

    it 'does not store non-JSON requests' do
      get :text
    end

    it 'does not store when document: false', document: false do
      get :json
    end

    it 'does not store when document_if returns false' do
      Avocado::Config.document_if = -> { false }
      get :json
    end
  end

  describe 'File uploads' do
    around do |example|
      Avocado.reset!
      example.run
      assertion.call
    end

    let(:assertion) do
      -> { Avocado.payload.first[:request][:params]['file'].should == "<Multipart File Upload>" }
    end

    it 'should show when files are uploaded' do
      get :json, file: Rack::Test::UploadedFile.new(__FILE__, 'text/plain')
    end
  end

  describe 'Avocado.payload' do
    around do |example|
      Avocado.reset!
      example.run
      assertion.call
    end

    context 'with params' do
      let(:assertion) do
        -> { Avocado.payload.first[:request][:params].should == { 'parameter' => '123' } }
      end

      it 'should have sent the params' do
        get :json, parameter: 123
      end
    end

    context 'with headers' do
      let(:assertion) do
        -> { Avocado.payload.first[:request][:headers].should == { 'X-Example-Header' => 123 } }
      end

      it 'should send the header' do
        @request.headers['X-Example-Header'] = 123
        Avocado::Config.headers = ['X-Example-Header']
        get :json, nil
      end
    end

    context 'ignored params' do
      let(:assertion) do
        -> { Avocado.payload.first[:request][:params].should == {} }
      end

      it 'should not contain ignored params that are concat' do
        Avocado::Config.ignored_params << 'parameter'
        get :json, parameter: 123
      end
    end

    context 'includes example description' do
      let(:assertion) do
        -> { Avocado.payload.first[:description].should == 'should have sent the description' }
      end

      it 'should have sent the description' do
        get :json
      end
    end

  end
end