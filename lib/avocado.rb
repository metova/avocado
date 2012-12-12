require 'avocado/engine'
require 'avocado/scenario'
require 'avocado/example_row'
require 'avocado/world'
require 'avocado/document/document'
require 'avocado/document/sidebar'
require 'avocado/document/documentation'

module Avocado
  @scenarios = []

  # Stores all scenario data while Cucumber is running tests
  def self.store(scenario, request, response)
    return if request.nil? or response.nil?
    resource = resource_from_url request.path, request.request_method
    return if resource.nil?

    scenario.resource = resource
    scenario.request = request
    scenario.response = response

    @scenarios << scenario
  end

  # Loop through all of the stored scenarios and write them to the view files
  def self.document!
    @resources = @scenarios.map(&:resource).uniq.sort

    sidebar = Avocado::Sidebar.new
    sidebar.populate @resources

    documentation = Avocado::Documentation.new
    documentation.populate @resources, @scenarios

    sidebar.save!
    documentation.save!
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

end
