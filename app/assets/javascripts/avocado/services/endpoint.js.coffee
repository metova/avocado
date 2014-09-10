angular.module('avocado.services').factory 'Endpoint', ['Request', 'Response', 'Resource', (Request, Response, Resource) ->

  class Endpoint
    constructor: (json) ->
      @request  = new Request(json.request)
      @response = new Response(json.response)
      @resource = new Resource(json.resource)

    @all: ->
      window.data.map (json) ->
        new Endpoint(json)
]