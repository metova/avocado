module Avocado
  class Sidebar < Document

    def initialize
      super 'app/views/avocado/dashboard/_sidebar.html.erb'
    end

    # Populates the sidebar with resource anchor links
    def populate(resources)
      resources.each do |r|
        append resource_list_item_representation(r)
      end
    end

protected

    # HTML that represents a list item on the sidebar
    def resource_list_item_representation(resource)
      b = html_builder
      b.li { b.a({ :href => "##{resource.parameterize}" }, resource) }
    end
  end
end