app.controller('ConversationCtrl', function($scope, $http, shareDataService) {

    $scope.conversations = [];

    $scope.active_user;

    $scope.messages = [];

    $http({
        url: 'conversations.json',
        method: "GET"
    }).then(function successCallback(response) {
        $scope.conversations = response.data.conversation;
        $scope.active_user = response.data.user.current_user;
    }, function errorCallback(response) {
        $scope.conversations = [];
    });

    $scope.users = shareDataService.getList();
    $scope.loadConversation = function (conversation){
        $scope.selected_conversation = {conversation: conversation, messages:{}};
        $http({
            url: "/conversations/"+conversation.id+"/messages.json",
            method: "GET"
        }).then(function successCallback(response) {
            $scope.messages = response.data;
            $scope.selected_conversation = {conversation: conversation, messages: $scope.messages };
        }, function errorCallback(response) {
            $scope.conversations = [];
        });
    }

    $scope.message = {};
    $scope.submitMessageForm = function() {
        $http({
            url: "conversations/"+$scope.message.conversation_id+"/messages.json",
            data: $scope.message,
            method: "POST"
        }).then(function successCallback(response) {
            $scope.selected_conversation.messages.push(response.data);
            $(".chat-history").animate({scrollTop: $(".chat-history").prop('scrollHeight')}, 3000);
        }, function errorCallback(response) {

        });
    };


});