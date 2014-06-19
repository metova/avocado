module Avocado
  class Parser

    attr_reader :resources, :endpoints, :requests

    def initialize(json)
      @resources = SortedSet.new
      @endpoints = Set.new
      @requests  = Set.new
      parse(json)
    end

    def resource(name)
      @resources.find { |r| r.name == name }
    end

    private

      def parse(json)
        json.each do |req|
          resource = find_or_create_resource_by_name req[:resource][:name]
          endpoint = find_or_create_endpoint_by_signature resource, req[:request]
          request  = instantiate_request_object_from(req)
          request.endpoint = endpoint

          if request.unique?(@requests)
            endpoint.requests << request
            resource.endpoints << endpoint
            @resources << resource
            @endpoints << endpoint
            @requests  << request
          end
        end
      end

      def instantiate_request_object_from(params)
        Avocado::Request.new \
          path:        params[:request][:path],
          params:      params[:request][:params],
          headers:     params[:request][:headers],
          status:      params[:response][:status],
          body:        params[:response][:body],
          description: params[:description]
      end

      def find_or_create_resource_by_name(name)
         resource(name) || Avocado::Resource.new(name: name)
      end

      def find_or_create_endpoint_by_signature(resource, request)
        signature = "#{request[:method]} #{request[:path]}"
        resource.endpoints.find { |e| e.signature == signature } || Avocado::Endpoint.new(signature: signature)
      end

  end
end