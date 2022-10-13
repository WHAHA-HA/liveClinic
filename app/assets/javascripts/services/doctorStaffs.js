angular.module('liveClinic')
    .factory('DoctorStaffs', [
        '$http',
        function($http){
            var doctorStaffs = {};
            /**
             * Fetch doctor's doctor_staff data
             * @param doctorId
             * @returns doctor_staff object
             */
            doctorStaffs.getDoctorStaff = function( id) {
                return $http.get('/api/doctor_staffs/' + id)
                    .then(function(response) {
                        return response.data;
                    });
            }

            doctorStaffs.getDoctorStaffs = function( ) {
                return $http.get('/api/doctor_staffs')
                    .then(function(response) {
                        return response.data;
                    });
            }

            doctorStaffs.updateDoctorStaff = function( id, data) {
                return $http.put('/api/doctor_staffs/' + id, data)
                    .then(function(response) {
                        return response.data;
                    });
            }

            doctorStaffs.removeDoctorStaff = function( data) {
                return $http.delete('/api/doctor_staffs/' + data['id'], data)
                    .then(function(response) {
                        return response.data;
                    });
            }

            doctorStaffs.createDoctorStaff = function( data) {
                return $http.post('/api/doctor_staffs', data)
                    .then(function(response) {
                        return response.data;
                    });
            }

            return doctorStaffs;
        }
    ]);