angular.module('avocado')

.factory 'RequestMethodFilter', ->
  class RequestMethodFilter
    constructor: (methods...) ->
      @methods = methods
      @active  = false
      @strict  = false

    getName: ->
      @methods[0]

    apply: (item) ->
      @methods.some (method) ->
        item.request.method == method
