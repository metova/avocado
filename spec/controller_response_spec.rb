RSpec.describe Avocado::ControllerResponse do
  describe '#documentable?' do
    it 'returns true if the response is a blank 204' do
      subject = described_class.new double(status: 204, body: '')
      expect(subject).to be_documentable
    end

    it 'returns true if the response is JSON parseable' do
      subject = described_class.new double(status: 200, body: '{"test":true}')
      expect(subject).to be_documentable
    end

    it 'returns false if the response is blank but not a 204' do
      subject = described_class.new double(status: 200, body: '')
      expect(subject).to_not be_documentable
    end

    it 'returns false if the response body is not JSON parseable' do
      subject = described_class.new double(status: 200, body: '<html></html>')
      expect(subject).to_not be_documentable
    end
  end
end
