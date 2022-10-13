angular.module('liveClinic')
    .controller('UserSessionsCtrl', [
        '$scope',
        '$rootScope',
        '$stateParams',
        function($scope, $rootScope, $stateParams){
            console.log($rootScope);
            $scope.$on('auth:login-error', function(ev, reason) {
                $scope.error = reason.errors[0];
            });
        }]);