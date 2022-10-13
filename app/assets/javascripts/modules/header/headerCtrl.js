angular.module('liveClinic')
    .controller('HeaderCtrl', [
        '$scope',
        '$state',
        '$stateParams',
        '$auth',
        function($scope, $state, $stateParams,$auth){
            $scope.openMenu = false;

            $scope.toggleMenu = function() {

                if ($scope.openMenu == true) {
                    $scope.openMenu = false;
                } else {
                    $scope.openMenu = true;
                }

                console.log($scope.openMenu);
            }

            $scope.handleSignout = function() {
                $auth.signOut()
                    .then(function(resp) {
                        // handle success response
                        $state.go('home', {}, {reload: true});
                    })
                    .catch(function(resp) {
                        // handle error response
                    });
            }
        }]);