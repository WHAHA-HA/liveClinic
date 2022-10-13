angular.module('liveClinic')
    .factory('Tasks', [
        '$http',
        function($http){
            var tasks = {};
            /**
             * Fetch doctor's facility data
             * @param doctorId
             * @returns facility object
             */
            tasks.getTask = function(id) {
                return $http.get('/api/tasks/' + id)
                    .then(function(response) {
                        return response.data;
                    });
            };

            tasks.getTasks = function() {
                return $http.get('/api/tasks')
                    .then(function(response) {
                        return response.data;
                    });
            };

            tasks.updateTask = function(data) {
                return $http.put('/api/tasks/' + data['id'], data)
                    .then(function(response) {
                        return response.data;
                    });
            };

            tasks.removeTask = function(id) {
                return $http.delete('/api/tasks/' + id)
                    .then(function(response) {
                        return response.data;
                    });
            };

            tasks.createTask = function(data) {
                return $http.post('/api/tasks', data)
                    .then(function(response) {
                        return response.data;
                    });
            };

            return tasks;
        }
    ]);