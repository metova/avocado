RSpec.describe Avocado::Adapters::RSpecAdapter do
  let(:spec) { double :spec, description: 'test' }
  let(:request) { double :request, xhr?: false }
  let(:response) { double :response }

  subject { described_class.new spec, request, response }

  describe '#description' do
    it 'returns the description of the spec object' do
      expect(subject.description).to eq 'test'
    end
  end

  describe '#upload?' do
    it 'returns true if the document metadata is not exactly false' do
      subject.spec = double :spec, metadata: { document: nil }
      expect(subject).to be_upload
    end

    it 'returns false if the document metadata is false' do
      subject.spec = double :spec, metadata: { document: false }
      expect(subject).to_not be_upload
    end
  end
end
