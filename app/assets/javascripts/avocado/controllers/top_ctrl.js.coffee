angular.module('avocado.controllers').
  controller 'TopCtrl', ['$scope', 'Endpoint', ($scope, Endpoint) ->
    console.log Endpoint
    $scope.endpoints = Endpoint.all()
  ]