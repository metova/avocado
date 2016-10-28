angular.module('avocado')

.factory 'Response', ->
  class Response
    constructor: (json) ->
      @statusCode = json.status

      try
        @body = JSON.stringify JSON.parse(json.body), undefined, 2
      catch e
        @body = ''
