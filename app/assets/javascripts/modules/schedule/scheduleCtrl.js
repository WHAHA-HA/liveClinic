angular.module('liveClinic')
.controller('ScheduleCtrl', [
	'$scope',
	'$rootScope',
	'$state',
	'$stateParams',
	'$auth',
	'Patients',
	'Doctors',
	'DoctorStaffs',
	'Facilities',
	'Schedules',
	function($scope, $rootScope, $state, $stateParams, $auth, Patients, Doctors, DoctorStaffs, Facilities, Schedules) {
		init();

		function init() {
			Schedules.getSchedules( ).then( function( response ) {
				var temp = [];
				response.forEach( function ( item, idx ) {
					temp.push( {
						title 	: item.title,
						start 	: moment(item.start_time).format('YYYY-MM-DD\THH:mm:ss'),
						end 	: moment(item.end_time).format('YYYY-MM-DD\THH:mm:ss')
					})
				});
				$scope.eventData = temp;
			});

			$scope.calendarOption = {
				header: {
					left: 'agendaDay,agendaWeek,month',
					center: 'title',
					right: 'today prev,next'
				},
				businessHours: true, // display business hours
				editable: true,
				defaultView: 'agendaDay'
			};

			$scope.appointment = {};

			Patients.getPatients( ).then( function( response ) {
				$scope.patients = response;
			});

			DoctorStaffs.getDoctorStaffs( ).then( function( response ) {
				$scope.providers = response;
			});

			Facilities.getFacilities( ).then( function( response ) {
				$scope.facilities = response;
			});
		};

		$scope.addAppointment = function () {
			Schedules.createSchedule( {
				"start_time" 	: $scope.appointment.when,
				"end_time" 		: $scope.appointment.end_time,
				"title" 		: $scope.appointment.complant,
				"patient_id"	: $scope.appointment.patient,
				"facility_id"	: $scope.appointment.facility,
				"doctor_id"		: $rootScope.user.owner_id
			}).then( function( response ) {
				$scope.eventData.push({
					title	: $scope.appointment.complant,
					start	: $scope.appointment.when,
					end 	: $scope.appointment.end_time,
					id		: response.id
				});

				$scope.appointment = {};
			} );
		};

		$scope.duration = function () {
			return ( $scope.appointment.end_time - $scope.appointment.when ) / 1000 / 60;
		}
	}
]);