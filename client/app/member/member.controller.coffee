'use strict'

angular.module 'vagrantDataApp'
.controller 'MemberCtrl', ($scope, $http, socket) ->
  $scope.members = []
  $http.get('/api/members').success (members) ->
    $scope.members = members
    socket.syncUpdates('member', $scope.members)
  $scope.createMember = ->
    if $scope.member && $scope.member.name
      $http.post('/api/members', $scope.member).success ->
        $scope.member.name = ''