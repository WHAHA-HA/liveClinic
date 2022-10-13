var directives = angular.module('liveClinic');
directives.directive('showTab',
    function () {
        return {
            restrict: 'A',
            link: function (scope, element, attrs) {
                // console.log( element );
                $(element).click(function(e) {
                    e.preventDefault();
                    $(element).tab('show');
                });
            }
        };
    });