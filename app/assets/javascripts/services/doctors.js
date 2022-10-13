angular.module('liveClinic')
    .factory('Doctors', [
        '$http',
        function($http){
            var doctors = {};

            /**
             * Fetch doctor data from doctor id
             * @param id
             * @returns {*}
             */
            doctors.getDoctor = function(id) {
                return $http.get('/api/doctors/' + id)
                    .then(function(response) {
                        return response.data;
                    });
            };

            doctors.updateDoctor = function(id, data) {
                return $http.put('/api/doctors/' + id, data)
                    .then(function(response) {
                        return response.data;
                    });
            }

            return doctors;
        }
    ]);