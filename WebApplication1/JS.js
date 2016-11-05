var app = angular.module('BlankApp', ['ngMaterial']);

app.controller('AppCtrl', ['$scope', '$mdSidenav', function($scope, $mdSidenav) {
//button//
  $scope.UAMUrl = 'http://amu.edu.pl';
  $scope.WMIUrl = 'http://wmi.amu.edu.pl';
  $scope.loginUrl = 'login.html';
  $scope.userUrl = 'user.html';
  $scope.arkuszUrl = 'arkusz.html';
  $scope.registryUrl = 'registry.html';
  $scope.startUrl = 'start.html';
//layout//
  $scope.toggleSidenav = function(menuId) {
    $mdSidenav(menuId).toggle();
  };
}]);
function pewnosc(x) {
    if (confirm("Are you sure?") == true) {
        window.location.href= x;
    }
	else{}
}

(function() {
  'use strict';
  angular.module('navBarDemoBasicUsage', ['ngMaterial'])
      .controller('AppCtrl', AppCtrl);
  function AppCtrl($scope) {
    $scope.currentNavItem = 'page1';
  }
})();