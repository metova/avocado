describe Avocado::Serializers::ResponseSerializer do
  subject { described_class.new double(body: 'test', status: 200) }

  describe '#to_h' do
    it 'serializes the response body' do
      expect(subject.to_h[:body]).to eq 'test'
    end

    it 'serializes the response status' do
      expect(subject.to_h[:status]).to eq 200
    end
  end
end
