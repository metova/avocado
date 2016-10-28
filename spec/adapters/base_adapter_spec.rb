RSpec.describe Avocado::Adapters::BaseAdapter do
  let(:spec) { double :spec }
  let(:request) { double :request, xhr?: false }
  let(:response) { double :response }

  subject { described_class.new spec, request, response }

  describe '#upload?' do
    it 'returns true if the response should be uploaded' do
      expect(subject).to be_upload
    end

    it 'returns false if the request is nil' do
      subject.request = nil
      expect(subject).to_not be_upload
    end

    it 'returns false if the request is AJAX' do
      subject.request = double xhr?: true
      expect(subject).to_not be_upload
    end

    it 'returns false if the response is nil' do
      subject.response = nil
      expect(subject).to_not be_upload
    end

    it 'returns false if the document_if config is nil' do
      Avocado.document_if = proc { false }
      expect(subject).to_not be_upload
    end

    it 'returns false if a block is passed that is nil' do
      expect(subject.upload? { false }).to be_falsy
    end
  end
end
