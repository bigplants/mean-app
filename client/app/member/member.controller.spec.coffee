'use strict'

describe 'Controller: MemberCtrl', ->

  # load the controller's module
  beforeEach module 'vagrantDataApp'
  MemberCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MemberCtrl = $controller 'MemberCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
