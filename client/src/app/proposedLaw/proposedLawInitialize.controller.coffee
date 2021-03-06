angular.module 'client'
  .controller 'ProposedLawInitializeCtrl', ( $scope, $state, $timeout,
    ProposedLaw, proposedLaw) ->
      timeout = null
      cancelTimeout = ->
        $timeout.cancel(timeout) if timeout
      reloadProposedLaw = ->
        cancelTimeout()
        ProposedLaw.get({proposedLawId:$scope.proposedLaw.id},$scope.onProposedLawLoad)
        if $scope.proposedLaw.workingRepoCreated
          $state.go('^.node',{proposedLawId:$scope.proposedLaw.id})
        else
          timeout = $timeout( reloadProposedLaw, 1000 )
      reloadProposedLaw()
      $scope.$on '$destroy', ->
        cancelTimeout()
