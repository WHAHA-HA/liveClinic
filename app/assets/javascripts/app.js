angular.module('liveClinic', ['ui.router', 'templates', 'ng-token-auth', 'ngLodash', 'file-model', 'ng-file-model', 'ngAnimate', 'ui.bootstrap.datetimepicker', 'ui.dateTimeInput', 'ngFileUpload', 'angularSpinner'])
	.config([
		'$stateProvider',
		'$urlRouterProvider',
		'$httpProvider',
		function(
			$stateProvider,
			$urlRouterProvider,
			$httpProvider
			) {

			$httpProvider.defaults.headers.common['Accept'] = 'application/json';

			function authenticateRoute($auth, $state) {
				return $auth.validateUser()
					.catch(function(res) {
						$state.go('sign_in');
					});
			}

			$stateProvider
				.state('home', {
					url: '/home',
					views: {
						'header': {
							templateUrl: 'modules/header/header.html',
							controller: 'HeaderCtrl'
						},
						'left-sidebar': {
							templateUrl: 'modules/sidebar/left-sidebar.html',
							controller: 'LeftSidebarCtrl'
						},
						'content': {
							templateUrl: 'modules/home/home.html',
							controller: 'MainCtrl'
						},
						'right-sidebar': {
							templateUrl: 'modules/sidebar/right-sidebar.html',
							controller: 'RightSidebarCtrl'
						}
					},
					resolve: {
						auth: authenticateRoute
					}
				})
				.state('sign_in', {
					url: '/sign_in',
					views: {
						'content': {
							templateUrl: 'modules/user_sessions/new.html',
							controller: 'UserSessionsCtrl'
						}
					}
				})
				.state('sign_up', {
					url: '/sign_up',
					views: {
						'content': {
							templateUrl: 'modules/user_registrations/new.html',
							controller: 'UserRegistrationsCtrl'
						}
					}
				})
				.state('posts', {
					url: '/posts',
					views: {
						'header': {
							templateUrl: 'modules/header/header.html',
							controller: 'HeaderCtrl'
						},
						'content': {
							templateUrl: 'modules/posts/_posts.html',
							controller: 'PostsCtrl'
						}
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('my-practice', {
					url: '/my-practice',
					views: {
						'header': {
							templateUrl: 'modules/header/header.html',
							controller: 'HeaderCtrl'
						},
						'left-sidebar': {
							templateUrl: 'modules/sidebar/left-sidebar.html',
							controller: 'LeftSidebarCtrl'
						},
						'content': {
							templateUrl: 'modules/my_practice/my-practice.html',
							controller: 'MyPracticeCtrl'
						},
						'right-sidebar': {
							templateUrl: 'modules/sidebar/right-sidebar.html',
							controller: 'RightSidebarCtrl'
						}
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('my-facilities', {
					url: '/my-facilities',
					views: {
						'header': {
							templateUrl: 'modules/header/header.html',
							controller: 'HeaderCtrl'
						},
						'left-sidebar': {
							templateUrl: 'modules/sidebar/left-sidebar.html',
							controller: 'LeftSidebarCtrl'
						},
						'content': {
							templateUrl: 'modules/my_facilities/my-facilities.html',
							controller: 'MyFacilitiesCtrl'
						},
						'right-sidebar': {
							templateUrl: 'modules/sidebar/right-sidebar.html',
							controller: 'RightSidebarCtrl'
						}
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('profile', {
					url: '/profile',
					views: {
						'header': {
							templateUrl: 'modules/header/header.html',
							controller: 'HeaderCtrl'
						},
						'left-sidebar': {
							templateUrl: 'modules/sidebar/left-sidebar.html',
							controller: 'LeftSidebarCtrl'
						},
						'content': {
							templateUrl: 'modules/profile/profile.html',
							controller: 'ProfileCtrl'
						},
						'right-sidebar': {
							templateUrl: 'modules/sidebar/right-sidebar.html',
							controller: 'RightSidebarCtrl'
						}
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('my-users', {
					url: '/my-users',
					views: {
						'header': {
							templateUrl: 'modules/header/header.html',
							controller: 'HeaderCtrl'
						},
						'left-sidebar': {
							templateUrl: 'modules/sidebar/left-sidebar.html',
							controller: 'LeftSidebarCtrl'
						},
						'content': {
							templateUrl: 'modules/my_users/my-users.html',
							controller: 'MyUsersCtrl'
						},
						'right-sidebar': {
							templateUrl: 'modules/sidebar/right-sidebar.html',
							controller: 'RightSidebarCtrl'
						}
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('schedule', {
					url: '/schedule',
					views: {
						'header': {
							templateUrl: 'modules/header/header.html',
							controller: 'HeaderCtrl'
						},
						'left-sidebar': {
							templateUrl: 'modules/sidebar/left-sidebar.html',
							controller: 'LeftSidebarCtrl'
						},
						'content': {
							templateUrl: 'modules/schedule/schedule.html',
							controller: 'ScheduleCtrl'
						},
						'right-sidebar': {
							templateUrl: 'modules/sidebar/right-sidebar.html',
							controller: 'RightSidebarCtrl'
						}
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('charts', {
					url: '/charts',
					views: {
						'header': {
							templateUrl: 'modules/header/header.html',
							controller: 'HeaderCtrl'
						},
						'left-sidebar': {
							templateUrl: 'modules/sidebar/left-sidebar.html',
							controller: 'LeftSidebarCtrl'
						},
						'content': {
							templateUrl: 'modules/charts/charts.html',
							controller: 'ChartsCtrl'
						},
						'right-sidebar': {
							templateUrl: 'modules/sidebar/right-sidebar.html',
							controller: 'RightSidebarCtrl'
						}
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('add-patient', {
					url: '/charts/add-patient',
					views: {
						'header': {
							templateUrl: 'modules/header/header.html',
							controller: 'HeaderCtrl'
						},
						'left-sidebar': {
							templateUrl: 'modules/sidebar/left-sidebar.html',
							controller: 'LeftSidebarCtrl'
						},
						'content': {
							templateUrl: 'modules/charts/add-patient.html',
							controller: 'ChartsCtrl'
						},
						'right-sidebar': {
							templateUrl: 'modules/sidebar/right-sidebar.html',
							controller: 'RightSidebarCtrl'
						}
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('edit-patient', {
					url: '/charts/edit-patient/:patientId',
					views: {
						'header': {
							templateUrl: 'modules/header/header.html',
							controller: 'HeaderCtrl'
						},
						'left-sidebar': {
							templateUrl: 'modules/sidebar/left-sidebar.html',
							controller: 'LeftSidebarCtrl'
						},
						'content': {
							templateUrl: 'modules/charts/add-patient.html',
							controller: 'ChartsCtrl'
						},
						'right-sidebar': {
							templateUrl: 'modules/sidebar/right-sidebar.html',
							controller: 'RightSidebarCtrl'
						}
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('tasks', {
					url: '/tasks',
					views: {
						'header': {
							templateUrl: 'modules/header/header.html',
							controller: 'HeaderCtrl'
						},
						'left-sidebar': {
							templateUrl: 'modules/sidebar/left-sidebar.html',
							controller: 'LeftSidebarCtrl'
						},
						'content': {
							templateUrl: 'modules/tasks/tasks.html',
							controller: 'TasksCtrl'
						},
						'right-sidebar': {
							templateUrl: 'modules/sidebar/right-sidebar.html',
							controller: 'RightSidebarCtrl'
						}
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('messages', {
					url: '/messages',
					views: {
						'header': {
							templateUrl: 'modules/header/header.html',
							controller: 'HeaderCtrl'
						},
						'left-sidebar': {
							templateUrl: 'modules/sidebar/left-sidebar.html',
							controller: 'LeftSidebarCtrl'
						},
						'content': {
							templateUrl: 'modules/messages/messages.html',
							controller: 'MessagesParentCtrl'
						}
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('messages.inbox-fax', {
					url: '/inbox',
					views: {
						'inner-content': {
							templateUrl: 'modules/messages/inbox-fax.html',
							controller: 'MessagesCtrl'
						},
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('messages.inbox-lab-result', {
					url: '/inbox',
					views: {
						'inner-content': {
							templateUrl: 'modules/messages/inbox-lab-result.html',
							controller: 'MessagesCtrl'
						},
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('messages.inbox-referrals', {
					url: '/inbox',
					views: {
						'inner-content': {
							templateUrl: 'modules/messages/inbox-referrals.html',
							controller: 'MessagesCtrl'
						},
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('messages.inbox-patient-message', {
					url: '/inbox',
					views: {
						'inner-content': {
							templateUrl: 'modules/messages/inbox-patient-message.html',
							controller: 'MessagesCtrl'
						},
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('messages.sent-fax', {
					url: '/sent',
					views: {
						'inner-content': {
							templateUrl: 'modules/messages/sent-fax.html',
							controller: 'MessagesCtrl'
						},
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('messages.sent-referrals', {
					url: '/sent',
					views: {
						'inner-content': {
							templateUrl: 'modules/messages/sent-referrals.html',
							controller: 'MessagesCtrl'
						},
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('messages.sent-patient-message', {
					url: '/sent',
					views: {
						'inner-content': {
							templateUrl: 'modules/messages/sent-patient-message.html',
							controller: 'MessagesCtrl'
						},
					},
					resolve: {
						auth: authenticateRoute
					}
				}).state('reports', {
					url: '/reports',
					views: {
						'header': {
							templateUrl: 'modules/header/header.html',
							controller: 'HeaderCtrl'
						},
						'left-sidebar': {
							templateUrl: 'modules/sidebar/left-sidebar.html',
							controller: 'LeftSidebarCtrl'
						},
						'content': {
							templateUrl: 'modules/reports/reports.html',
							controller: 'ReportsCtrl'
						}
					},
					resolve: {
						auth: authenticateRoute
					}
				});
			$urlRouterProvider.otherwise('/home');

		}])
	.run(['$rootScope', '$state', '$auth', function($rootScope, $state, $auth) {
		$rootScope.$on('auth:login-success', function(ev, user) {
			console.log("login success");
			$rootScope.currentUser = user;

			$state.go('home');
		});
		$rootScope.$on('auth:logout-success', function(ev, user) {
			console.log("logout success");
			$rootScope.currentUser = null;

			$state.go('sign_in');
		});
		$rootScope.$on('auth:validation-success', function(ev, user) {
			console.log("user validation success");

			$rootScope.currentUser = user;
		});

		$rootScope.$on('$stateChangeStart', function ( event, toState, toParam, fromState ) {
			if ( toState.url == "/messages" ) {
				event.preventDefault();
				if ( fromState.name.indexOf( "messages." ) != 0 )
					$state.go( "messages.inbox-fax" );
			}
		});
		
	}]);
