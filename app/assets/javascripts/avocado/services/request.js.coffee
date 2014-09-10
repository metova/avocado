angular.module('avocado.services').factory 'Request', ->

  class Request
    constructor: (json) ->
      console.log json