angular.module('liveClinic')
	.controller('ProfileCtrl', [
		'$scope',
		'$rootScope',
		'$state',
		'$stateParams',
		'$auth',
		'Profile',
		'Facilities',
		'Countries',
		'Utilities',
		function($scope, $rootScope, $state, $stateParams, $auth, Profile, Facilities, Countries, Utilities){

			var profile = {};
			var facilities = [];
			init();

			function init() {
				$scope.infoType = "login";
				$scope.countryList = Countries.getCountryList();
				$scope.editProfile = angular.copy(profile);

				Profile.loadProfile().then(
					function(response) {
						if (response != null) {
							profile = response;
						}

						$scope.editProfile = angular.copy(profile);
					}
				);

				Facilities.getFacilities().then(
					function(response) {
						if (response != null) {
							facilities = response;

						}
						$scope.facilities = angular.copy(facilities);
					}
				);
			}

			function saveLogin() {
				console.log($scope.currentUser);
				$auth.updateAccount($scope.currentUser)
					.then(function(resp) {
						$scope.updateState = {status: "success", message: "Login info has been successfully updated."}
					})
					.catch(function(resp) {
						$scope.updateState = {status: "danger", message: "We are sorry, we are unable to update login info."}
					});
			}

			function saveProfile() {
				Profile.updateProfile($scope.editProfile).then(success, error);

				function success(response) {
					$scope.updateState = {status: "success", message: "Profile has been successfully updated."}
				}

				function error(response) {
					$scope.updateState = {status: "danger", message: "We are sorry, we are unable to update profile."}
				}
			}

			$scope.selectTab = function(e, type) {
				e.preventDefault();
				$scope.infoType = type;
			}

			$scope.saveProfile = function() {
				if ($scope.infoType == "profile") {
					saveProfile();
				} else if ($scope.infoType == "login") {
					saveLogin();
				}
			}

			$scope.cancel = function() {
				$scope.editPractice = angular.copy(practice);
				$scope.updateState = null;
			}

			$scope.uploadFile = function (file) {
				Utilities.upload( file, "avatars/doctors", function( data ) {
					$scope.currentUser.avatar = data.Location;
					$scope.$apply( )
				}, function(err) {
					console.log( err );
					alert( 'Cannot upload to s3 bucket' ); 
				} );
			}

		}]);