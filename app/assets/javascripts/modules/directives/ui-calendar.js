angular.module('liveClinic')
.constant('uiCalendarConfig', {calendars: {}})
.directive('uiCalendar', ['uiCalendarConfig', function(uiCalendarConfig) {
	return {
		restrict: 'A',
		scope: { eventSources: '=ngModel', initOptions: '=ngOption' },
		// controller: 'uiCalendarCtrl',
		link: function ( scope, elm, attrs, controller ) {
			scope.onClickEvent = function ( event, jsEvent, view ) {
				// scope.eventSources = calendar.fullCalendar('clientEvents') ;
			};

			scope.onClickDay = function ( day, jsEvent, view ) {
				// scope.eventSources = calendar.fullCalendar('clientEvents') ;
			};

			scope.onEventDrop = function ( event, delta, revertFunc, jsEvent, ui, view ) {
				scope.eventSources = getRefinedData( calendar.fullCalendar('clientEvents') );
				scope.$apply();
			};

			scope.onEventResize = function ( event, delta, revertFunc, jsEvent, ui, view ) {
				scope.eventSources = getRefinedData( calendar.fullCalendar('clientEvents') );
				scope.$apply();
			};
 
			scope.destroy = function () {
				if ( calendar && calendar.fullCalendar ) {
					calendar.fullCalendar( 'destroy' );
				}
				if ( attrs.calendar ) {
					calendar = uiCalendarConfig.calendars[attrs.calendar] = $(elm).html('');
				} else {
					calendar = $(elm).html('');
				}
			};

			scope.init = function () {
				calendar.fullCalendar( options );

				if ( attrs.calendar ) {
					uiCalendarConfig.calendars[attrs.calendar] = calendar;
				}
			};

			scope.$watch( 'eventSources', function ( new0, old0 ) {
				if ( calendar && calendar.fullCalendar ) {
					if ( ! new0 ) new0 = []; 
					if ( ! old0 ) old0 = [];

					for ( var p = old0.length; p < new0.length; p++) {
						calendar.fullCalendar( 'renderEvent', new0[p], true );
					}
				}
			}, true );

			function getRefinedData( obj ) {
				var output = [];

				obj.forEach( function ( obj, idx ) {
					output.push ( {
						title: obj.title,
						start: obj.start?obj.start.format('YYYY-MM-DD\THH:mm:ssZ'):null,
						end: obj.end?obj.end.format('YYYY-MM-DD\THH:mm:ssZ'):null,
						background: obj.background?obj.background:null
					} );
				});

				return output;
			};

			var calendar;
				sources = scope.eventSources,
				sourcesChange = false;

			var	options = {
					eventClick: scope.onClickEvent,
					dayClick: scope.onClickDay,
					eventDrop: scope.onEventDrop,
					eventResize: scope.onEventResize,

					events: sources
				};

			angular.extend( options, scope.initOptions );

			scope.destroy();
			scope.init();
		}
	}
}]);