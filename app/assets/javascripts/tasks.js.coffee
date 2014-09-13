# Define App and dependencies
TaskApp = angular.module("TaskApp", ["ngRoute", "templates", "ui.bootstrap"])

# Setup the angular router
TaskApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
	$routeProvider
		.when '/',
			templateUrl: "index.html",
			controller: "TasksCtrl"
		.otherwise
			redirectTo: "/"

	$locationProvider.html5Mode(true)

]

# TaskApp Controller
TaskApp.cotroller "TasksCtrl", ["$scope", "$http", ($scope, $http) ->



]



# Define Config for CSRF token
TaskApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]



