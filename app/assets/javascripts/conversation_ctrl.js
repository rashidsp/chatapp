app.controller('ConversationCtrl', function($scope, $http, shareDataService) {

    $scope.conversations = [];

    $scope.active_user;

    $scope.messages = [];

    $http({
        url: 'conversations.json',
        method: "GET"
    }).then(function successCallback(response) {
        $scope.conversations = response.data.conversations;
        $scope.active_user = response.data.user.current_user;
        $scope.loadConversation(response.data.conversations[0]);
        $(".chat-history").animate({scrollTop: $(".chat-history").prop('scrollHeight')}, 1000);
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
            url: "conversations/"+$scope.selected_conversation.conversation.id+"/messages.json",
            data: $scope.message,
            method: "POST"
        }).then(function successCallback(response) {
            $scope.message = {};
        }, function errorCallback(response) {

        });
    };

    App.chat = App.cable.subscriptions.create("ChatChannel", {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {

        console.log($scope.selected_conversation.conversation.id)

        // $scope.message = {};
        // $scope.selected_conversation.messages.push(data);
        // $(".chat-history").animate({scrollTop: $(".chat-history").prop('scrollHeight')}, 3000);
      },
      speak: function(message) {
        return this.perform('speak', {
          message: message
        });
      }
});


});