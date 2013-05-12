require 'avocado/scenario'
require 'avocado/example_row'
require 'avocado/world'
require 'erb'

module Avocado
  @scenarios = []

  # Stores all scenario data while Cucumber is running tests
  def self.store(scenario, request, response)
    return if request.nil? or response.nil?
    resource = resource_from_url request.path, request.request_method
    return if resource.nil?

    scenario.resource = resource.split('/').last
    scenario.request = request
    scenario.response = response
    @scenarios << scenario
  end

  # Generate the documentation from the stored scenarios
  def self.document!
    template = IO.read documentation_template_path
    @resources = @scenarios.map(&:resource).uniq.sort
    documentation = ERB.new(template).result binding

    File.open documentation_destination_path, 'w+' do |f|
      f.write documentation
    end
  end

protected

  # Examine the Method/URL from the request object using recognize_path, then parse
  # the controller key to get the resource that the request is acting on. If the route
  # cannot be recognized, `nil` is returned
  def self.resource_from_url(path, method)
    Rails.application.routes.recognize_path(path, :method => method)[:controller].partition('/').last.titleize
  rescue ActionController::RoutingError
    nil
  end

  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.documentation_template_path
    File.join root, 'lib', 'avocado', 'views', 'documentation.html.erb'
  end

  def self.documentation_destination_path
    File.join Rails.root, 'public', 'api-docs.html'
  end

end
