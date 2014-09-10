angular.module('avocado.services').factory 'Resource', ->

  class Resource
    constructor: (json) ->
      @name = json.name