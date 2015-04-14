'use strict'

angular.module 'vagrantDataApp'
.controller 'MemberCtrl', ($scope, $http) ->
  $scope.members = []
  $http.get('/api/members').success (members) ->
    $scope.members = members
  $scope.createMember = ->
    if $scope.member && $scope.member.name
      $scope.members.push name: $scope.member.name
      $scope.member.name = ''