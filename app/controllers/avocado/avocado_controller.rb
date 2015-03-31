module Avocado
  class AvocadoController < ActionController::Base

    def create
      File.open(json, 'a+:UTF-8') { |f| f.write params[:file].read }
      head :ok
    end

    def index
      @data = File.read(json)
      render '/template'
    end

    private

      def json
        Avocado::Config.json_path.join('avocado.json')
      end

  end
end
