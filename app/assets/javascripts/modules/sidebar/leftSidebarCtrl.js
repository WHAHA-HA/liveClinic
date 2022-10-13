angular.module('liveClinic')
    .controller('LeftSidebarCtrl', [
        '$scope',
        '$state',
        '$stateParams',
        function($scope, $state, $stateParams){
            $scope.isActive = function(url){
                return $state.current.url == url
            }
        }]);