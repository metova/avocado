angular.module('avocado')

.factory 'Resource', ->
  class Resource
    constructor: (json) ->
      @name = json.name
