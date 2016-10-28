angular.module('avocado')

.controller 'AvocadoCtrl', ['$scope', '$location', 'Spec', 'ResponseStatusFilter', 'RequestMethodFilter', ($scope, $location, Spec, ResponseStatusFilter, RequestMethodFilter) ->
  new class AvocadoCtrl
    constructor: ->
      @allSpecs = Spec.all()
      @specs = Spec.all()
      @query = undefined
      @activeSpec = @_findActiveSpec() if @_specUUIDGiven()
      @activeResource = 'All'

      @filters = [
        new ResponseStatusFilter(200, 299, true)
        new RequestMethodFilter('GET')
        new RequestMethodFilter('POST')
        new RequestMethodFilter('PATCH', 'PUT')
        new RequestMethodFilter('DELETE')
      ]

    chooseSpec: (spec) ->
      @activeSpec = spec
      $location.path spec.uuid

    chooseResource: ->
      resourceName = @activeResource.replace /\s+/g, ''
      @specs = if resourceName is 'All' then @allSpecs else Spec.forResource(resourceName)

    getFilteredSpecs: ->
      specs = @specs
      activeFilters  = @filters.filter (f) -> f.active
      strictFilters  = activeFilters.filter (f) -> f.strict
      relaxedFilters = activeFilters.filter (f) -> !f.strict

      specs.filter (spec) ->
        result = strictFilters.every((f) -> f.apply(spec))
        result &&= relaxedFilters.some((f) -> f.apply(spec)) if relaxedFilters.length > 0
        result

    search: (spec) =>
      return true if !@query
      [spec.request.path, spec.description].some (term) =>
        term.toLowerCase().indexOf(@query.toLowerCase()) != -1

    _findActiveSpec: ->
      specUUID = $location.path().substr 1
      @activeSpec = @allSpecs.find (spec) -> spec.uuid == specUUID

    _specUUIDGiven: ->
      $location.path().length > 0
  ]
