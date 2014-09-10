angular.module('avocado.services', [])
angular.module('avocado.controllers', ['avocado.services'])

app = angular.module('avocado', ['ngRoute', 'avocado.services', 'avocado.controllers'])