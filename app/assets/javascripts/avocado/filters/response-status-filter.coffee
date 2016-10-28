angular.module('avocado')

.factory 'ResponseStatusFilter', ->
  class ResponseStatusFilter
    constructor: (minCode, maxCode, active = false) ->
      @minCode = minCode
      @maxCode = maxCode
      @active  = active
      @strict  = true

    getName: ->
      @minCode

    apply: (item) ->
      @minCode <= item.response.statusCode <= @maxCode
