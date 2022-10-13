angular.module('liveClinic')
	.factory('Patients', [
		'$http',
		function($http){
			var patients = {};
			/**
			 * Fetch patient data
			 * @param patientId
			 * @returns patient object
			 */

			patients.getPatients = function( ) {
				return $http.get('/api/patients')
					.then(function(response) {
						return response.data;
					});
			}

			patients.getPatient = function( patientId ) {
				return $http.get('/api/patients/' + patientId)
					.then(function(response) {
						return response.data;
					});
			}

			patients.updatePatient = function(patientId, data) {
				return $http.put('/api/patients/' + patientId, data)
					.then(function(response) {
						return response.data;
					});
			}

			patients.removePatient = function(patientId) {
				return $http.delete('/api/patients/' + patientId)
					.then(function(response) {
						return response.data;
					});
			}

			patients.createPatient = function(data) {
				return $http.post('/api/patients/', data)
					.then(function(response) {
						return response.data;
					});
			}

			return patients;
		}
	]);