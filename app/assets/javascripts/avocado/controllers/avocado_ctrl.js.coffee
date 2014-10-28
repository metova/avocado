angular.module('avocado.controllers').
  controller 'AvocadoCtrl', ['$scope', 'Endpoint', ($scope, Endpoint) ->

    $scope.allEndpoints = Endpoint.all()
    $scope.endpoints = Endpoint.all()
    $scope.filteredEndpoints = $scope.endpoints
    $scope.activeFilters = []

    $scope.switchResource = ->
      resourceName = $scope.selectedResource.replace(/\s+/g, "")
      if resourceName is 'All'
        $scope.endpoints = Endpoint.all()
      else
        $scope.endpoints = Endpoint.findByResource(resourceName)

    $scope.chooseEndpoint = (endpoint) ->
      $scope.currentEndpoint = endpoint

    $scope.filters = [
      {
        name: 'Only show 200s',
        selected: false,
        strict: true
        includedWhen: (endpoint) ->
          200 <= endpoint.response.statusCode <= 299
      },
      {
        name: 'GET',
        selected: true,
        includedWhen: (endpoint) ->
          endpoint.request.method == 'GET'
      },
      {
        name: 'POST',
        selected: true,
        includedWhen: (endpoint) ->
          endpoint.request.method == 'POST'
      },
      {
        name: 'PUT',
        selected: true,
        includedWhen: (endpoint) ->
          endpoint.request.method == 'PUT'
      },
      {
        name: 'DELETE',
        selected: true,
        includedWhen: (endpoint) ->
          endpoint.request.method == 'DELETE'
      }
    ]

    $scope.filterEndpoints = ->
      endpoints = $scope.endpoints

      # apply strict filters first
      for filter in $.grep($scope.activeFilters, (f) -> f.strict)
        endpoints = $.grep endpoints, filter.includedWhen

      # go through non-strict filters and add them to the result
      filteredEndpoints = []
      for filter in $.grep($scope.activeFilters, (f) -> !f.strict)
        for endpoint in endpoints
          filteredEndpoints.push endpoint if filter.includedWhen(endpoint)

      $scope.filteredEndpoints = filteredEndpoints

    $scope.$watch 'filters | filter:{selected:true}', (filters) ->
      $scope.activeFilters = filters
      $scope.filterEndpoints()
    , true

    $scope.$watch 'endpoints', (endpoints) ->
      $scope.filterEndpoints()

    $scope.search = (endpoint) ->
      query = $scope.query
      return true if !query
      terms = [ endpoint.request.path, endpoint.description ]
      for term in terms
        return true if term.indexOf(query) != -1
      false

  ]