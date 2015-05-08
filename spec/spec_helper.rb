ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
require 'bundler/setup'

require 'combustion'
require 'avocado/rspec'
require 'webmock/rspec'

Combustion.initialize! :all

require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

module HookAssertions
  def document(example, &block)
    example.metadata[:assertions] = block
  end
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.order = 'random'
  config.include HookAssertions

  config.after(:suite) do
    WebMock.stub_request(:post, /localhost/).to_return status: 200
  end

  config.around(:each) do |example|
    example.run
    if assertions = example.metadata[:assertions]
      assertions.call
    end
    Avocado.reset!
  end
end
