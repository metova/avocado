ENV['RAILS_ENV'] ||= 'test'

require 'rubygems'
require 'bundler/setup'

require 'combustion'
require 'timecop'
require 'avocado/rspec'
require 'webmock/rspec'

Combustion.initialize! :all
WebMock.disable_net_connect!

require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.order = :random

  config.after(:each) do
    Avocado.reset!
  end
end
