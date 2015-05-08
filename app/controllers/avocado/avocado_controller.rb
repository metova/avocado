module Avocado
  class AvocadoController < ActionController::Base

    def create
      File.open(json, 'w+') { |f| f.write params[:file].read }
      head :ok
    end

    def index
      @data = File.read(json)
      render '/template'
    end

    private

      def json
        Avocado.json_path.join('avocado.json')
      end

  end
end
