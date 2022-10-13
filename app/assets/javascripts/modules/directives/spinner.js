var directives = angular.module('liveClinic');
directives.directive('usSpinner', ['$http', '$rootScope', 'usSpinnerService', function ($http, $rootScope, usSpinnerService) {
	return {
		link: function (scope, elm, attrs)
		{
			$rootScope.spinnerActive = false;
			scope.isLoading = function () {
				return $http.pendingRequests.length > 0;
			};

			scope.$watch(scope.isLoading, function (loading)
			{
				$rootScope.spinnerActive = loading;
				if(loading){
					usSpinnerService.spin(attrs.spinnerKey)
				} else {
					usSpinnerService.stop(attrs.spinnerKey)
				}
			});
		}
	}
}]);