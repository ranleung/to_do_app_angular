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
	$scope.displayContent = true

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

	$scope.panel = ->
		if this.displayContent
			this.displayContent = false
		else
			this.displayContent = true


	# DESTROY
	$scope.deleteTask = (task) ->
		conf = confirm "You will delete this task.  Are you sure?"
		if conf
			console.log("Deleteing this task id:", task.id)
			$http.delete("/tasks/#{task.id}.json").success (data) ->
				$scope.tasks.splice($scope.tasks.indexOf(task),1)
				console.log("here?")

	# UPDATE
	$scope.updateTask = (task) ->
		console.log("Updating task:", task)
		this.checked = false
		$http.put("/tasks/#{this.task.id}.json", task).success (data) ->
			console.log(data)
]

# Define Config for CSRF token
TaskApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]