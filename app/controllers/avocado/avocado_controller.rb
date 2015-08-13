module Avocado
  class AvocadoController < ActionController::Base

    def create
      contents = params[:file].read
      Rails.logger.info "Avocado file contents: #{contents}"
      File.open(json, 'w+:UTF-8') { |f| f.write contents }
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
