RSpec.describe Avocado::Adapters::CucumberAdapter do
  let(:spec) { double :spec, name: 'test', tags: [double(name: 'test')] }
  let(:request) { double :request, xhr?: false }
  let(:response) { double :response }

  subject { described_class.new spec, request, response }

  describe '#description' do
    it 'returns the description of the spec object' do
      expect(subject.description).to eq 'test'
    end
  end

  describe '#upload?' do
    it 'returns true if there is not a nodoc tag' do
      expect(subject).to be_upload
    end

    it 'returns false if there is a nodoc tag' do
      subject.spec = double :spec, tags: [double(name: 'nodoc')]
      expect(subject).to_not be_upload
    end
  end
end
