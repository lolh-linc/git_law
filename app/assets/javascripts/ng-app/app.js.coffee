angular
  .module 'gitLaw', [ 'angularFileUpload', 'ngAnimate', 'ngSanitize', 'ui.select', 'ui.router',
    'ngResource', 'templates', 'ui.utils',
    'ui.bootstrap', 'angular-chartist' ]
  .config ($stateProvider, $urlRouterProvider, $locationProvider,
    uiSelectConfig ) ->
    uiSelectConfig.theme = 'bootstrap'
    $stateProvider
      .state 'home', {
        url: '/',
        views:
          "navigation":
            templateUrl: 'navbar.html'
            controller: 'NavigationCtrl'
          "content":
            templateUrl: 'home.html'
            controller: 'HomeCtrl'
      }
      .state 'signin', {
        url: '/sign-in',
        views:
          "navigation":
            templateUrl: 'navbar.html'
            controller: 'NavigationCtrl'
          "content":
            templateUrl: 'userSession/new.html'
            controller: 'UserSessionCtrl'
      }
      .state 'code', {
        abstract: true,
        url: '/codes/:codeId',
        views:
          "navigation":
            templateUrl: 'navbar.html'
            controller: 'NavigationCtrl'
          "content":
            templateUrl: 'code/layout.html'
            controller: 'CodeCtrl'
      }
      .state 'code.proposed', {
        abstract: true,
        url: '',
        views:
          "pane":
            templateUrl: 'code/proposed.html'
            controller: 'ProposedLawsCtrl'
      }
      .state 'code.proposed.one', {
        url: '',
        templateUrl: 'code/proposedList.html',
        controller: 'ProposedLawsListCtrl'
      }
      .state 'codes', {
        abstract: true,
        url: '/codes',
        views:
          "navigation":
            templateUrl: 'navbar.html'
            controller: 'NavigationCtrl'
          "content":
            templateUrl: 'codes/layout.html'
            controller: 'CodesCtrl'
      }
      .state 'codes.one', {
        url: '',
        templateUrl: 'codes/list.html',
        controller: 'CodesListCtrl'
      }
      .state 'codes.paginated', {
        url: '/page/:page'
        templateUrl: 'codes/list.html'
        controller: 'CodesListCtrl'
      }
    $urlRouterProvider.otherwise '/'
    $locationProvider.html5Mode true
