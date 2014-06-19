module Avocado
  class AvocadoController < ActionController::Base

    def create
      File.open(yaml, 'w+') { |f| f.write params[:file].read }
      head :ok
    end

    def index
      hash = YAML.load File.read(yaml)
      @data = Avocado::Parser.new(hash)
      render '/template'
    end

    private

      def yaml
        Avocado::Config.yaml_path.join('avocado.yml')
      end

  end
end
