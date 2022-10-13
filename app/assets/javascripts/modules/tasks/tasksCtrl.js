angular.module('liveClinic')
.controller('TasksCtrl', [
	'$scope',
	'$rootScope',
	'$state',
	'$stateParams',
	'$auth',
	"Patients",
	"DoctorStaffs",
	"Tasks",
	'lodash',
	function($scope, $rootScope, $state, $stateParams, $auth, Patients, DoctorStaffs, Tasks, lodash){
		init();

		function init() {
			$scope.task = {};

			Patients.getPatients( ).then( function( response ) {
				$scope.patients = response;
			});

			DoctorStaffs.getDoctorStaffs( ).then( function( response ) {
				$scope.providers = response;
			});

			loadData();
		};

		function loadData() {
			Tasks.getTasks().then(function (response) {
				$scope.tasks = response;
			});
		}

		$scope.diffCalc = function (from) {
			var duration = moment.duration( moment().diff( from ) );
			return duration.humanize();
		}

		$scope.duePassed = function ( due ) {
			if ( moment().diff( due ) > 0 ) {
				return "color-red";
			} else {
				return "";
			}
		}

		$scope.saveTask = function () {
			if ( $scope.task.id ) {
				Tasks.updateTask( $scope.task ).then(function (response) {
					loadData();
				});
			}
			else {
				Tasks.createTask( $scope.task ).then(function (response) {
					loadData();
				});
			}
		}

		$scope.markAsDone = function (id) {
			_.each( $scope.tasks, function ( obj, idx ) {
				if ( obj.id == id ) {
					obj.active = 1;
					Tasks.updateTask( obj ).then( function (response) {
						$scope.tasks[idx] = obj
					} );
				}
			} );
		}

		$scope.filterDone = function ( item ) {
			if ( item && item.active && item.active == 1 ) {
				return true;
			}
			else {
				return false;
			}
		}

		$scope.filterNotDone = function ( item ) {
			if ( item && item.active && item.active == 1 ) {
				return false;
			}
			else {
				return true;
			}
		}

		$scope.newTask = function () {
			$scope.task = {};
		}

		$scope.loadTask = function ( obj ) {
			$scope.task = obj;
		}

		$scope.removeTask = function ( tId ) { 
			Tasks.removeTask( tId ).then(function (response) {
				loadData();
			});
		}
	}
]);