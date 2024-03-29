// Generated by CoffeeScript 1.8.0
var TaskApp;

TaskApp = angular.module("TaskApp", ["ngRoute", "templates", "ui.bootstrap"]);

TaskApp.config([
  "$routeProvider", "$locationProvider", function($routeProvider, $locationProvider) {
    $routeProvider.when('/', {
      templateUrl: "index.html",
      controller: "TasksCtrl"
    }).otherwise({
      redirectTo: "/"
    });
    return $locationProvider.html5Mode(true);
  }
]);

TaskApp.controller("TasksCtrl", [
  "$scope", "$http", function($scope, $http) {
    $scope.tasks = [];
    $scope.displayContent = true;
    $scope.getTasks = function() {
      return $http.get("/tasks.json").success(function(data) {
        $scope.tasks = data;
        return console.log(data);
      });
    };
    $scope.getTasks();
    $scope.addTask = function() {
      return $http.post("/tasks.json", $scope.newTask).success(function(data) {
        $scope.newTask = {};
        console.log(data);
        return $scope.tasks.push(data);
      });
    };
    $scope.panel = function() {
      if (this.displayContent) {
        return this.displayContent = false;
      } else {
        return this.displayContent = true;
      }
    };
    $scope.deleteTask = function(task) {
      var conf;
      conf = confirm("You will delete this task.  Are you sure?");
      if (conf) {
        console.log("Deleteing this task id:", task.id);
        return $http["delete"]("/tasks/" + task.id + ".json").success(function(data) {
          $scope.tasks.splice($scope.tasks.indexOf(task), 1);
          return console.log("here?");
        });
      }
    };
    $scope.showUpdateForm = function() {
      if (this.checked) {
        return this.checked = false;
      } else {
        return this.checked = true;
      }
    };
    return $scope.updateTask = function(task) {
      console.log("Updating task:", task);
      this.checked = false;
      return $http.put("/tasks/" + this.task.id + ".json", task).success(function(data) {
        return console.log(data);
      });
    };
  }
]);

TaskApp.config([
  "$httpProvider", function($httpProvider) {
    return $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }
]);
