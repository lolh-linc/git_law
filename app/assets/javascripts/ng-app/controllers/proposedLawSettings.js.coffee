angular
  .module 'gitLaw'
  .controller( 'ProposedLawSettingsCtrl', ['$scope', '$modalInstance',
  '$upload', 'proposedLaw', 'ProposedLaw',
  ( $scope, $modalInstance, $upload, proposedLaw, ProposedLaw ) ->
    $scope.alerts = [ ]
    $scope.errors = { }
    $scope.proposedLaw = proposedLaw
    $scope.save = (proposedLaw) ->
      success = ( proposedLaw ) ->
        $modalInstance.close proposedLaw
      failure = ( response ) ->
        $scope.alerts.push( { type: 'danger', msg: "Save failed." } )
        $scope.errors = response.data.errors
      if proposedLaw.id
        proposedLaw.$save( success, failure )
      else
        ProposedLaw.create( proposedLaw, success, failure )
    $scope.cancel = ->
      $modalInstance.dismiss()
  ])
