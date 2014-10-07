angular.module('avocado.services').factory 'Request', ->

  class Request
    constructor: (json) ->
      @method = json.method
      @path = json.path
      @params = JSON.stringify(json.params, undefined, 2)

      @headers = ""
      for name,value of json.headers
        @headers = "#{@headers}\n#{name}: #{value}"
      @headers = @headers.trim()
