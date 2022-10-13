angular.module('liveClinic')
    .controller('UserRegistrationsCtrl', [
        '$scope',
        '$stateParams',
        '$auth',
        '$sce',
        function($scope, $stateParams, $auth, $sce){
            $scope.$on('auth:registration-email-error', function(ev, reason) {
//                $scope.error = reason.errors[0];
                if (reason.status == "error") {
                    console.log(reason);
//                    if (reason.errors.email.length > 0) {
//                        var email_error = "";
//                        reason.errors.email.each(function(msg) {
//                            email_error += msg;
//                        });
//                        angular.forEach(reason.errors.email, function(value, key) {
//
//                        }, log);
//                        $scope.email_error = $sce.trustAsHtml(email_error);
//                    }
//                    if (reason.errors.password.length > 0) {
//                        var password_error = "";
//                        reason.errors.password.each(function(msg) {
//                            password_error += msg;
//                        });
//                        $scope.password_error = $sce.trustAsHtml(password_error);
//                    }
                    $scope.error = reason.errors;
                }
            });
            $scope.handleRegBtnClick = function() {
                console.log
                $auth.submitRegistration($scope.registrationForm)
                    .then(function() {
                        $auth.submitLogin({
                            email: $scope.registrationForm.email,
                            password: $scope.registrationForm.password
                        });
                    });
            };

        }]);