angular.module('liveClinic')
	.factory('Schedules', [
		'$http',
		function($http){
			var schedules = {};

			schedules.getSchedule = function(id) {
				return $http.get('/api/doctor_schedules/' + id)
					.then(function(response) {
						return response.data;
					});
			}

			schedules.getSchedules = function() {
				return $http.get('/api/doctor_schedules')
					.then(function(response) {
						return response.data;
					});
			}

			schedules.updateSchedule = function(data) {
				return $http.put('/api/doctor_schedules/' + data['id'], data)
					.then(function(response) {
						return response.data;
					});
			}

			schedules.removeSchedule = function(data) {
				return $http.delete('/api/doctor_schedules/' + data['id'], data)
					.then(function(response) {
						return response.data;
					});
			}

			schedules.createSchedule = function(data) {
				return $http.post('/api/doctor_schedules', data)
					.then(function(response) {
						return response.data;
					});
			}

			return schedules;
		}
	]);