angular.module('avocado.services').factory 'Endpoint', ['Request', 'Response', 'Resource', (Request, Response, Resource) ->

  class Endpoint
    constructor: (json) ->
      @description = json.description
      @request  = new Request(json.request)
      @response = new Response(json.response)
      @resource = new Resource(json.resource)

    @all: ->
      window.data.map (json) ->
        new Endpoint(json)

    @findByResource: (resourceName) ->
      $.grep @all(), (endpoint) =>
        endpoint.resource.name == resourceName

]