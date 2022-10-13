angular.module('liveClinic')
    .controller('MyUsersCtrl', [
        '$scope',
        '$rootScope',
        '$state',
        '$stateParams',
        'lodash',
        'DoctorStaffs',
        'AccessLevels',
        'Countries',
        function($scope, $rootScope, $state, $stateParams, lodash, DoctorStaffs, AccessLevels, Countries){

            var doctorStaffs = [];

            var doctorStaff = {
                access_level_id: null,
                is_admin: null,
                user_attributes: {
                    first_name: "",
                    last_name: "",
                    email: "",
                    password: "test1234",
                    password_confirmation: "test1234"
                }
            };

            var accessLevels = [];

            init();

            function init() {
                $scope.countryList = Countries.getCountryList();
                $scope.newDoctorStaff = angular.copy(doctorStaff);

                loadAccessLevel();
                loadDoctorStaffs();
            }

            function loadAccessLevel() {
                AccessLevels.getAccessLevelList().then( success );

                function success(response) {
                    if (response != null) {
                        accessLevels = response;
                    }
                    $scope.accessLevels = angular.copy(accessLevels);
                    console.log($scope.accessLevels);
                }
            }

            function loadDoctorStaffs() {
                DoctorStaffs.getDoctorStaffs().then( success );

                function success(response) {
                    if (response != null) {
                        doctorStaffs = response;
                    }
                    $scope.doctorStaffs = angular.copy(doctorStaffs);
                }
            }

            $scope.addDoctorStaff = function() {

                DoctorStaffs.createDoctorStaff({doctor_staff: $scope.newDoctorStaff}).then(success, error);

                function success(response) {
                    $scope.updateState = {status: "success", message: "DoctorStaff has been successfully added."};
                    doctorStaffs[doctorStaffs.length] = response;

                    $scope.doctorStaffs = doctorStaffs;

                }

                function error(response) {
                    $scope.updateState = {status: "danger", message: "We are sorry, we are unable to add doctor staff."};
                }


            }

            $scope.saveDoctorStaff = function() {
                var data = $scope.selectedDoctorStaff;
//                data['password'] = "";
                DoctorStaffs.updateDoctorStaff($scope.selectedDoctorStaff.id, {doctor_staff: data}).then(success, error);

                function success(response) {
                    $scope.updateState = {status: "success", message: "DoctorStaff has been successfully updated."};

                    _.each(doctorStaffs, function(obj, index) {
                        if (obj.id == $scope.selectedDoctorStaff.id) {
                            obj = angular.copy($scope.selectedDoctorStaff);
                            doctorStaffs[index] = obj;
                        }
                    });

                    $scope.doctorStaffs = doctorStaffs;

                }

                function error(response) {
                    $scope.updateState = {status: "danger", message: "We are sorry, we are unable to update doctorStaff."};
                }

            }

            $scope.removeDoctorStaff = function() {
                DoctorStaffs.removeDoctorStaff($scope.selectedDoctorStaff).then(success, error);

                function success(response) {
                    $scope.updateState = {status: "success", message: "DoctorStaff has been successfully removed."};

                    doctorStaffs = _.reject(doctorStaffs, function(obj, index) {
                        return (obj.id == $scope.selectedDoctorStaff.id);
                    });

                    $scope.doctorStaffs = doctorStaffs;

                }

                function error(response) {
                    $scope.updateState = {status: "danger", message: "We are sorry, we are unable to remove doctor staff."};
                }
            }

            $scope.selectDoctorStaff = function(data) {
                $scope.selectedDoctorStaff = angular.copy(data);
            }


            $scope.cancelSelectDoctorStaff = function() {
                $scope.selectedDoctorStaff = null;
                $scope.updateState = null;
            }

            $scope.cancelAddDoctorStaff = function() {
                $scope.newDoctorStaff = angular.copy(doctorStaff);
                $scope.updateState = null;
            }


            $scope.cancelSaveDoctorStaff = function() {
                $scope.newDoctorStaff = angular.copy(doctorStaff);
                $scope.updateState = null;
            }

        }]);