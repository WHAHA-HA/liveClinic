angular.module('liveClinic')
.controller('ChartsCtrl', [
	'$scope',
	'$rootScope',
	'$state',
	'$stateParams',
	'$auth',
	'Patients',
	'Utilities', 
	function($scope, $rootScope, $state, $stateParams, $auth, Patients, Utilities){
		init();

		function init() {
			$scope.patient = {};
			$scope.patients = [];

			if ( $state.current.name == 'edit-patient' ) {
				if ( $stateParams.patientId == "" ) {
					$state.go( 'charts' );
				} else {
					Patients.getPatient( $stateParams.patientId ).then( function (response) {
						$scope.patient = response;
					});
				}
			}

			if ( $state.current.name == 'charts' ) {
				Patients.getPatients( ).then( function (response) {
					$scope.patients = response;
				} );
			}

		};

		$scope.savePatient = function () {
			if ( $scope.patient.id ) {
				Patients.updatePatient(
					$scope.patient.id, $scope.patient
				).then( function () {
					$state.go( 'charts' );
				});
			} else {
				Patients.createPatient(
					$scope.patient
				).then( function () {
					$state.go( 'charts' );
				});
			}
		};

		$scope.uploadFile = function (file) {
			Utilities.upload( file, "avatars/patients", function( data ) {
				console.log( data );
				$scope.patient.avatar = data.Location;
				$scope.$apply( )
			}, function(err) {
				console.log( err );
				alert( 'Cannot upload to s3 bucket' ); 
			} );
		}
	}
]);