describe Avocado::Storage, document: false do
  subject { described_class.instance }

  describe '#store' do
    it 'stores the request and response' do
      req = double :request, xhr?: false
      res = double :response

      subject.store req, res
      expect(subject.request).to eq req
      expect(subject.response).to eq res
    end
  end

  describe '#clear' do
    it 'clears the request and response' do
      subject.clear
      expect(subject.request).to be_nil
      expect(subject.response).to be_nil
    end
  end
end
