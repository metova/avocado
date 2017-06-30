module Avocado
  class SpecsController < ::ActionController::Base
    layout 'avocado'

    def index
      @data = storage.read
    end

    def create
      storage.write params[:file].read, upload_id
      storage.purge_old upload_id
      head :ok
    end

    private
      def storage
        Avocado.storage
      end

      def upload_id
        params[:upload_id]
      end
  end
end
