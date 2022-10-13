angular.module('liveClinic')
.controller('MessagesCtrl', [
	'$scope',
	'$rootScope',
	'$state',
	'$stateParams',
	'$auth',
	'lodash',
	'Utilities',
	function($scope, $rootScope, $state, $stateParams, $auth, lodash, Utilities){
		$scope.newData = {};
		$scope.data = {};

		init();

		function init() {
			// 0 : lab-result
			// 1 : referrals
			// 2 : patient-messages

			if ( $state.current.name == "messages.inbox-fax" ) {
				Utilities.faxInbox().then(setScopeData);
			} else if ( $state.current.name == "messages.sent-fax" ) {
				Utilities.faxSent().then(setScopeData);
			} else if ( $state.current.name == "messages.inbox-lab-result" ) {
				Utilities.mailInbox(0).then(setScopeData);
			} else if ( $state.current.name == "messages.inbox-referrals" ) {
				Utilities.mailInbox(1).then(setScopeData);
			} else if ( $state.current.name == "messages.inbox-patient-message" ) {
				Utilities.mailInbox(2).then(setScopeData);
			} else if ( $state.current.name == "messages.sent-referrals" ) {
				Utilities.mailSent(1).then(setScopeData);
			} else if ( $state.current.name == "messages.sent-patient-message" ) {
				Utilities.mailSent(2).then(setScopeData);
			}
		};

		function setScopeData(resp) {
			if (resp.data.success == 'fail') {
				$scope.res = { type: 'danger', message: resp.data.error };
			}
			else {
				$scope.data = resp.data;
			}
		};

		$scope.readyFile = function ( file ) {
			$scope.newData.file = file;
		};

		$scope.sendFax = function () {
			Utilities.sendFax( $scope.newData, function(resp) {
				$scope.res = { type: 'success', message: 'Fax successfully sent' }
			}, function(err) {
				console.log( err );
				$scope.res = { type: 'warning', message: 'Error occured : ' + err }
			});
		};

		$scope.deleteFaxInbox = function(id) {
			Utilities.deleteFaxInbox(id).then(function(resp) {
				if (resp.data.success == 'ok') {
					lodash.remove( $scope.data, function(o) { return o.id == id } );
				}
			})
		}

		$scope.readFaxInbox = function(id) {
			Utilities.readFaxInbox(id).then(function(resp) {
				if (resp.data.success == 'ok') {
					var idx = lodash.findIndex($scope.data, {'id': id});
					lodash.set( $scope.data, "[" + idx + "].is_read", true);
				}
			})
		}

		$scope.deleteFaxSent = function(id) {
			Utilities.deleteFaxSent(id).then(function(resp) {
				if (resp.data.success == 'ok') {
					lodash.remove( $scope.data, function(o) { return o.id == id } );
				}
			})
		}

		$scope.resendFax = function(id) {

		}

		$scope.sendMail = function(type) {
			$scope.newData.mail_type = type;

			Utilities.sendMail( $scope.newData, function(resp) {
				console.log(resp);
				$scope.res = { type: 'success', message: 'Mail successfully sent' }
			}, function(err) {
				console.log(err);
				$scope.res = { type: 'warning', message: 'Error occured : ' + err }
			});
		}

		$scope.deleteMailInbox = function(id) {
			Utilities.deleteMailInbox(id).then(function(resp) {
				if (resp.data.success == 'ok') {
					lodash.remove( $scope.data, function(o) { return o.id == id } );
				}
			})
		}

		$scope.deleteMailSent = function(id) {
			Utilities.deleteMailSent(id).then(function(resp) {
				if (resp.data.success == 'ok') {
					lodash.remove( $scope.data, function(o) { return o.id == id } );
				}
			})
		}

		$scope.readMailInbox = function(id) {
			Utilities.readMailInbox(id).then(function(resp) {
				if (resp.data.success == 'ok') {
					var idx = lodash.findIndex($scope.data, {'id': id});
					lodash.set( $scope.data, "[" + idx + "].is_read", true);
				}
			})
		}
	}
]);