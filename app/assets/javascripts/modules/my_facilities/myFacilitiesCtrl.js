angular.module('liveClinic')
    .controller('MyFacilitiesCtrl', [
        '$scope',
        '$rootScope',
        '$state',
        '$stateParams',
        'lodash',
        'Facilities',
        'Countries',
        function($scope, $rootScope, $state, $stateParams, lodash, Facilities, Countries){

            var facilities = [];

            var facility = {
                name: "",
                phone: "",
                fax: "",
                address: "",
                zip: "",
                city: "",
                state: "",
                country: ""
            };

            init();

            function init() {
                $scope.countryList = Countries.getCountryList();
                $scope.newFacility = angular.copy(facility);

                loadFacilities();
            }

            function loadFacilities() {
                Facilities.getFacilities().then( success );

                function success(response) {
                    if (response != null) {
                        facilities = response;
                    }
                    $scope.facilities = angular.copy(facilities);
                }
            }

            $scope.addFacility = function() {

                Facilities.createFacility($scope.newFacility).then(success, error);

                function success(response) {
                    $scope.updateState = {status: "success", message: "Facility has been successfully added."};
                    facilities[facilities.length] = response;

                    $scope.facilities = facilities;
                }

                function error(response) {
                    $scope.updateState = {status: "danger", message: "We are sorry, we are unable to add facility."};
                }

                console.log($scope.newFacility);
            }

            $scope.saveFacility = function() {

                Facilities.updateFacility($scope.selectedFacility).then(success, error);

                function success(response) {
                    $scope.updateState = {status: "success", message: "Facility has been successfully updated."};

                    _.each(facilities, function(obj, index) {
                        if (obj.id == $scope.selectedFacility.id) {
                            obj = angular.copy($scope.selectedFacility);
                            facilities[index] = obj;
                        }
                    });

                    $scope.facilities = facilities;

                }

                function error(response) {
                    $scope.updateState = {status: "danger", message: "We are sorry, we are unable to update facility."};
                }

                console.log($scope.newFacility);
            }

            $scope.removeFacility = function() {
                Facilities.removeFacility($scope.selectedFacility).then(success, error);

                function success(response) {
                    $scope.updateState = {status: "success", message: "Facility has been successfully removed."};

                    facilities = _.reject(facilities, function(obj, index) {
                        return (obj.id == $scope.selectedFacility.id);
                    });

                    $scope.facilities = facilities;

                }

                function error(response) {
                    $scope.updateState = {status: "danger", message: "We are sorry, we are unable to remove facility."};
                }
            }

            $scope.selectFacility = function(data) {
                $scope.selectedFacility = angular.copy(data);
            }


            $scope.cancelSelectFacility = function() {
                $scope.selectedFacility = null;
                $scope.updateState = null;
            }

            $scope.cancelAddFacility = function() {
                $scope.newFacility = angular.copy(facility);
                $scope.updateState = null;
            }


            $scope.cancelSaveFacility = function() {
                $scope.newFacility = angular.copy(facility);
                $scope.updateState = null;
            }

        }]);