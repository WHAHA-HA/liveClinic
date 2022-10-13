angular.module('liveClinic')
    .factory('AccessLevels', [
        '$http',
        function($http){
            var accessLevels = {};

            /**
             * Fetch doctor data from doctor id
             * @param id
             * @returns {*}
             */
            accessLevels.getAccessLevelList = function() {
                return $http.get('/api/access_levels/')
                    .then(function(response) {
                        return response.data;
                    });
            };


            return accessLevels;
        }
    ]);