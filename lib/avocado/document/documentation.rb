module Avocado
  class Documentation < Document
    def initialize
      super 'app/views/avocado/dashboard/_documentation.html.erb'
    end

    # Populates the documentation with all of the scenarios given. Resources
    # are also provided to generate the headers
    def populate(resources, scenarios)
      resources.each do |r|
        append resource_representation(r)

        # select only the scenarios that affect this resource
        scenarios.select { |s| s.resource == r }.sort_by(&:heading).each do |s|
          append scenario_representation(s)
        end
      end
    end

protected

    # HTML that represents a resource header
    def resource_representation(resource)
      b = html_builder
      b.div({ :class => "resource", :id => resource.parameterize }) do
        b.a({ :name => resource.parameterize }, "")
        b.h2 resource
        b.hr
      end
    end

    # HTML that represents a scenario
    def scenario_representation(scenario)
      b = html_builder
      request = scenario.request
      response = scenario.response

      b.div({ :class => "scenario" }) do
        b.a({ :href => "javascript:void(0);" }) do
          b.i({ :class => "caret" }, "")
          b.span scenario.heading
        end

        b.div({ :class => "scenario-details" }) do
          b.pre do
            b.i "Test Description"
            b.span scenario.steps
          end

          b.pre do
            b.i "Example JSON Request"
            b.span ["#{request.request_method} #{request.path}", request.params.to_json].join("\n")
          end

          b.pre do
            b.i "Example JSON Response"
            b.span ["Status: #{response.status}", response.body.gsub(',', ', ')].join("\n")
          end
        end
      end
    end
  end
end