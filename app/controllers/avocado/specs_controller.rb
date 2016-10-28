module Avocado
  class SpecsController < ::ActionController::Base
    layout 'avocado'

    def index
      @data = json_files.map { |filename| File.read filename }
    end

    def create
      File.open(new_json_filename, 'w+') { |f| f.write params[:file].read }
      File.delete(*json_files_from_past_uploads)
      head :ok
    end

    private
      def upload_id
        params[:upload_id]
      end

      def new_json_filename
        Avocado.json_path.join "avocado-#{Time.current.to_s(:nsec)}-#{Avocado.upload_id.call}.json"
      end

      def json_files
        Dir.glob Avocado.json_path.join('avocado*.json')
      end

      def json_files_from_past_uploads
        json_files.reject do |spec|
          spec.end_with? "-#{upload_id}.json"
        end
      end
  end
end
