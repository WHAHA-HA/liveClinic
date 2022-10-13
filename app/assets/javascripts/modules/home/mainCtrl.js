angular.module('liveClinic')
.controller('MainCtrl', [
    '$scope',
    '$rootScope',
    'posts',
    'Schedules',
    function ($scope, $rootScope, posts, Schedules) {

        $scope.test = 'Hello world!';
        $scope.posts = posts.posts;

        $scope.addPost = function () {
            if(!$scope.title || $scope.title === '') { return; }
            $scope.posts.push({
                title: $scope.title,
                link: $scope.link,
                upvotes: 0,
                comments: [
                    {author: 'Joe', body: 'Cool post!', upvotes: 0},
                    {author: 'Bob', body: 'Great idea but everything is wrong!', upvotes: 0}
                ]
            });
            $scope.title = '';
            $scope.link = '';
        };

        $scope.incrementUpvotes = function (post) {
            post.upvotes += 1;
        };

        Schedules.getSchedules( ).then( function( response ) {
            var temp = [];
            response.forEach( function ( item, idx ) {
                temp.push( {
                    title   : item.title,
                    start   : moment(item.start_time).format('YYYY-MM-DD\THH:mm:ss'),
                    end     : moment(item.end_time).format('YYYY-MM-DD\THH:mm:ss')
                })
            });
            $scope.eventData = temp;
        });

        $scope.calendarOption = {
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month'
            },
            businessHours: true, // display business hours
            editable: false,
        }
    }
]);