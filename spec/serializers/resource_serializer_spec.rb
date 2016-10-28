describe Avocado::Serializers::ResourceSerializer do
  describe '#to_h' do
    it 'infers the resource name from the controller parameter' do
      subject = described_class.new double(params: { controller: 'tests' })
      expect(subject.to_h[:name]).to eq 'Tests'
    end

    it 'infers the resource name when namespaced' do
      subject = described_class.new double(params: { controller: 'api/tests' })
      expect(subject.to_h[:name]).to eq 'Tests'
    end

    it 'infers the resource name when namespaces and has more than one word' do
      subject = described_class.new double(params: { controller: 'test_results' })
      expect(subject.to_h[:name]).to eq 'Test Results'
    end
  end
end
