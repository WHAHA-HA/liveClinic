angular.module('liveClinic')
    .factory('Practices', [
        '$http',
        function($http){
            var practices = {};
            /**
             * Fetch doctor's practice data
             * @param doctorId
             * @returns practice object
             */
            practices.getPractice = function() {
                return $http.get('/api/practice/')
                .then(function(response) {
                    return response.data;
                });
            }

            practices.updatePractice = function(data) {
                return $http.put('/api/practice/', data)
                .then(function(response) {
                    return response.data;
                });
            }

            return practices;
        }
    ]);