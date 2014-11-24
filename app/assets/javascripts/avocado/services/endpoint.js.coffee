angular.module('avocado.services').factory 'Endpoint', ['Request', 'Response', 'Resource', (Request, Response, Resource) ->

  class Endpoint
    constructor: (json) ->
      @description = json.description
      @request  = new Request(json.request)
      @response = new Response(json.response)
      @resource = new Resource(json.resource)
      @uuid = @generateMD5Hash(@request, @response)

    @all: ->
      window.data.map (json) ->
        new Endpoint(json)

    @findByResource: (resourceName) ->
      console.log "All: #{@all()}"
      console.log "resourceName: #{resourceName}"
      $.grep @all(), (endpoint) =>
        endpoint.resource.name == resourceName

    generateMD5Hash: (request, response) ->
      hashTarget = request.method + request.path + request.params + request.headers
      CryptoJS.MD5(hashTarget).toString().substr(0, 7);

]