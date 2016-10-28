RSpec.describe Avocado::Uploader do
  subject { described_class.instance }

  describe '#reset' do
    it 'sets the payload back to an empty array' do
      subject.payload = :test
      expect { subject.reset }.to change { subject.payload }.from(:test).to []
    end
  end

  describe '#url' do
    it 'returns nil if the URL is not parseable' do
      Avocado.url = 'Not a URL'
      expect(subject.url).to be_nil
    end
  end

  describe '#upload' do
    it 'does nothing if there is no payload' do
      subject.payload = nil
      expect(subject.upload).to eq nil
      expect(WebMock).to_not have_requested(:any, /(.*)/)
    end

    it 'does nothing if there is no url' do
      Avocado.url = nil
      expect(subject.upload).to eq nil
      expect(WebMock).to_not have_requested(:any, /(.*)/)
    end

    it 'sends the payload as a file to the configured URL' do
      Avocado.url = URI.parse 'http://localhost/'
      subject.payload = [{ test: true }]
      stub_request(:post, subject.url)
      subject.upload

      # WebMock doesn't support multipart body matching
      expect(WebMock).to have_requested(:post, subject.url)
    end
  end
end
