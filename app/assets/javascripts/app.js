var app = angular.module('chatApp', []);

app.controller('MainCtrl', function($scope, $http, $filter) {
    $scope.contacts;
    $scope.showAllContacts = function(keywords){
        $http({
            url: 'contacts.json',
            method: "GET",
            params: {keywords: keywords}
        }).then(function successCallback(response) {
            $scope.contacts = response.data;
        }, function errorCallback(response) {
            $scope.contacts = [];
        });
    }

    $scope.addFriend = function (friend_id) {
        $http({
            url: '/users/'+friend_id+'/friendships.json',
            method: "POST"
        }).then(function successCallback(response) {
            if (response.data.success == true ){
                updateContact(response.data.friend_id)
            }else{
                alert(response.data.message);
            }
        }, function errorCallback(response) {

        });
    }

    function updateContact(friend_id){
        angular.forEach($scope.contacts, function(contact) {
            if (contact.id == friend_id){
                contact.request_sent = true;
            }
        });
    }

});