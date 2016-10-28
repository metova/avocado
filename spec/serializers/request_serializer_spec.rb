describe Avocado::Serializers::RequestSerializer do
  let(:request) { double method: 'POST', path: 'api/tests', params: {}, headers: double(env: {}) }
  subject { described_class.new request }

  describe '#to_h' do
    it 'serializes the request method' do
      expect(subject.to_h[:method]).to eq 'POST'
    end

    it 'serializes the request path' do
      expect(subject.to_h[:path]).to eq 'api/tests'
    end

    it 'does not send ignored params' do
      Avocado.ignored_params = %w(test)
      expect(request).to receive(:params) { Hash['test' => true, 'test2' => true] }
      expect(subject.to_h[:params]).to eq 'test2' => true
    end

    it 'replaces file uploads with a string' do
      expect(request).to receive(:params) { Hash['test' => Tempfile.new] }
      expect(subject.to_h[:params]).to eq 'test' => '<Multipart File Upload>'
    end

    it 'deep replaces file uploads with a string' do
      expect(request).to receive(:params) { Hash['test' => { 'test2' => Tempfile.new }] }
      expect(subject.to_h[:params]).to eq 'test' => { 'test2' => '<Multipart File Upload>' }
    end

    it 'sends the headers in the header configuration' do
      Avocado.headers = %w(Content-Type)
      expect(request).to receive(:headers) { double env: { 'HTTP_CONTENT_TYPE' => 'application/json' } }
      expect(subject.to_h[:headers]).to eq 'Content-Type' => 'application/json'
    end

    it 'doesnt send headers when not explicitly configured' do
      Avocado.headers = %w()
      expect(subject.to_h[:headers]).to be_empty
    end
  end
end
