angular.module('liveClinic')
    .factory('Facilities', [
        '$http',
        function($http){
            var facilities = {};

            facilities.getFacility = function(id) {
                return $http.get('/api/facilities/' + id)
                    .then(function(response) {
                        return response.data;
                    });
            }

            facilities.getFacilities = function( ) {
                return $http.get('/api/facilities')
                    .then(function(response) {
                        return response.data;
                    });
            }

            facilities.updateFacility = function(data) {
                return $http.put('/api/facilities/' + data['id'], data)
                    .then(function(response) {
                        return response.data;
                    });
            }

            facilities.removeFacility = function(data) {
                return $http.delete('/api/facilities/' + data['id'], data)
                    .then(function(response) {
                        return response.data;
                    });
            }

            facilities.createFacility = function(data) {
                return $http.post('/api/facilities', data)
                    .then(function(response) {
                        return response.data;
                    });
            }

            return facilities;
        }
    ]);