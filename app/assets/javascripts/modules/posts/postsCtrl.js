angular.module('liveClinic')
    .controller('PostsCtrl', [
        '$scope',
        '$stateParams',
        'posts',
        'auth',
        function($scope, $stateParams, posts, auth){
            console.log("post controller called");
            console.log(auth);
            $scope.post = posts.posts[$stateParams.id];
            $scope.addComment = function(){
                if($scope.body === '') { return; }
                $scope.post.comments.push({
                    body: $scope.body,
                    author: 'user',
                    upvotes: 0
                });
                $scope.body = '';
            };
        }]);