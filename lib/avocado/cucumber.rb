require 'avocado'
require 'avocado/cucumber/scenario'
require 'avocado/cucumber/example_row'
# require 'avocado/world'

# World(Avocado::World)

After do |scenario|
  begin
    extension = "Avocado::#{scenario.class.name.demodulize}".safe_constantize
    extension.new(scenario).store(last_request, last_response) if extension
  rescue(Rack::Test::Error)
  end
end

at_exit do
  Avocado.document!
end