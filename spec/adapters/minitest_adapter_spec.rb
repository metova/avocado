RSpec.describe Avocado::Adapters::MinitestAdapter do
  let(:spec) { double :spec }
  let(:request) { double :request, xhr?: false }
  let(:response) { double :response }

  subject { described_class.new spec, request, response }

  describe '#description' do
    it 'returns the "spec", which in Minitest case is the name of the spec itself' do
      expect(subject.description).to eq spec
    end
  end
end
