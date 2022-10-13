angular.module('liveClinic')
    .controller('MyPracticeCtrl', [
        '$scope',
        '$rootScope',
        '$state',
        '$stateParams',
        'Practices',
        'Countries',
        function($scope, $rootScope, $state, $stateParams, Practices, Countries){

            var practice = {
                name: "",
                phone: "",
                fax: "",
                facility_name: "",
                address: "",
                suite: "",
                zip: "",
                city: "",
                state: "",
                country: ""
            };

            init();

            function init() {
                $scope.countryList = Countries.getCountryList();

                Practices.getPractice().then(
                    function(response) {
                        if (response != null) {
                            practice = response;

                        }
                        $scope.editPractice = angular.copy(practice);
                    }
                );
            }

            $scope.savePractice = function() {
                Practices.updatePractice($scope.editPractice).then(success, error);

                function success(response) {
                    $scope.updateState = {status: "success", message: "Practice has been successfully updated."}
//                  $scope.editPractice = angular.copy(response);
                }

                function error(response) {
                    $scope.updateState = {status: "danger", message: "We are sorry, we are unable to update practice."}
                }

                console.log($scope.editPractice);
            }

            $scope.cancel = function() {
                $scope.editPractice = angular.copy(practice);
                $scope.updateState = null;
            }

        }]);