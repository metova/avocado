RSpec.describe Avocado::SpecsController do
  routes { Avocado::Engine.routes }

  describe 'GET index' do
    
  end

  describe 'POST create' do
    let(:uploaded_file) { Rack::Test::UploadedFile.new File.expand_path('../../../fixtures/specs.json', __FILE__), 'text/plain' }

    before do
      Avocado.json_path = Rails.root
      Avocado.upload_id = -> { 'test' }
    end

    it 'reads the file parameter and writes it to the JSON path' do
      begin
        post :create, params: { file: uploaded_file, upload_id: 'test' }
        files = Dir.glob(Avocado.json_path.join('avocado*.json'))
        expect(files.size).to eq 1
        expect(File.read(files[0])).to include '{"test":true}'
      ensure
        File.delete(*files)
      end
    end

    it 'removes outdated spec files' do
      begin
        post :create, params: { file: uploaded_file, upload_id: 'outdated' }
        post :create, params: { file: uploaded_file, upload_id: 'test' }
        files = Dir.glob Avocado.json_path.join('avocado*test.json')
        expect(files.size).to eq 1
      ensure
        File.delete(*files)
      end
    end

    it 'does not remove files with the same upload ID' do
      begin
        post :create, params: { file: uploaded_file, upload_id: 'test' }
        post :create, params: { file: uploaded_file, upload_id: 'test' }
        files = Dir.glob Avocado.json_path.join('avocado*test.json')
        expect(files.size).to eq 2
      ensure
        File.delete(*files)
      end
    end
  end
end
