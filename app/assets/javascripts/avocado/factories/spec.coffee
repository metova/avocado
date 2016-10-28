angular.module('avocado')

.factory 'Spec', ['Request', 'Response', 'Resource', (Request, Response, Resource) ->

  class Spec
    constructor: (json) ->
      @description = json.description
      @request = new Request json.request
      @response = new Response json.response
      @resource = new Resource json.resource
      @uuid = @generateMD5Hash @request, @response

    @all: ->
      specs = []
      window.data.forEach (data) ->
        angular.fromJson(data).forEach (data) ->
          specs.push new Spec(data)
      specs

    @forResource: (resourceName) ->
      @all().filter (spec) ->
        spec.resource.name.replace(/\s+/g, '') == resourceName

    generateMD5Hash: (request, response) ->
      hashTarget = @description + request.method + request.path + request.params + request.headers
      md5(hashTarget).toString().substr 0, 7
]
