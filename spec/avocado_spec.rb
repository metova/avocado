RSpec.describe Avocado do
  describe '.configure' do
    it 'yields itself' do
      yep = false
      Avocado.configure { |avocado| yep = true if avocado == Avocado }
      expect(yep).to be_truthy
    end
  end

  describe '.reset!' do
    it 'resets the URL to nil' do
      Avocado.url = :test
      Avocado.reset!
      expect(Avocado.url).to eq nil
    end

    it 'resets the headers to a blank array' do
      Avocado.headers = [:test]
      Avocado.reset!
      expect(Avocado.headers).to eq []
    end

    it 'resets the json path to be the Rails root' do
      Avocado.json_path = :test
      Avocado.reset!
      expect(Avocado.json_path).to eq Rails.root
    end

    it 'resets the upload id to be a UUID' do
      expect(SecureRandom).to receive(:uuid) { 'uuid' }
      Avocado.upload_id = -> { 123 }
      Avocado.reset!
      expect(Avocado.upload_id.call).to eq 'uuid'
    end

    it 'resets the document if proc to be truthy' do
      Avocado.document_if = -> { false }
      Avocado.reset!
      expect(Avocado.document_if.call).to be_truthy
    end

    it 'resets the ignored params to be controller, action, and format' do
      Avocado.ignored_params = %w(test)
      Avocado.reset!
      expect(Avocado.ignored_params).to eq %w(controller action format)
    end
  end
end
