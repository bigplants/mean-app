'use strict'

angular.module 'vagrantDataApp'
.config ($stateProvider) ->
  $stateProvider.state 'member',
    url: '/member'
    templateUrl: 'app/member/member.html'
    controller: 'MemberCtrl'
