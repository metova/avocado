angular.module('avocado.services', [])
angular.module('avocado.controllers', ['avocado.services'])

app = angular.module('avocado', ['ngRoute', 'ui.utils', 'avocado.services', 'avocado.controllers'])