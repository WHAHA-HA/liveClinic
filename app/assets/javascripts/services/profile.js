angular.module('liveClinic')
	.factory('Profile', [
		'$http',
		function($http){
			var profile = {};
			profile.loadProfile = function() {
				return $http.get('/api/profile/')
					.then(function(response) {
						return response.data;
					});
			}

			profile.updateProfile = function(data) {
				return $http.put('/api/profile/', data)
					.then(function(response) {
						return response.data;
					});
			}

			return profile;
		}
	]);