app.controller('FriendsCtrl', function($scope, $http, shareDataService) {

    $scope.friends = [];
    $http({
        url: 'contacts.json',
        method: "GET"
    }).then(function successCallback(response) {
        angular.forEach(response.data, function(friend) {
            if (friend.is_friend == true){
                $scope.friends.push(friend);
                shareDataService.addList(friend);
            }
        });
    }, function errorCallback(response) {
        $scope.friends = [];
    });
});
