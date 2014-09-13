# Define App and dependencies
TaskApp = angular.module("TaskApp", ["ngRoute", "templates","ui.bootstrap"])

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

# Books Controller
TaskApp.controller "TasksCtrl", ["$scope", "$http", ($scope, $http) ->
	$scope.tasks =[]

	# READ
	$scope.getTasks = ->
		$http.get("/tasks.json").success (data) ->
			$scope.tasks = data
			console.log(data)

	$scope.getTasks()

	# CREATE
	$scope.addTask = ->
		$http.post("/tasks.json", $scope.newTask).success (data) ->
			$scope.newTask = {}
			console.log(data)
			$scope.tasks.push(data)



]

# Define Config for CSRF token
TaskApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]