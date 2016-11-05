var app = angular.module('BlankApp', ['ngMaterial']);

app.controller('AppCtrl', ['$scope', '$mdSidenav', function($scope, $mdSidenav) {
//button//
  $scope.UAMUrl = 'http://amu.edu.pl';
  $scope.WMIUrl = 'http://wmi.amu.edu.pl';
  $scope.loginUrl = 'login.html';
  $scope.userUrl = 'user.html';
  $scope.arkuszUrl = 'arkusz.html';
//layout//
  $scope.toggleSidenav = function(menuId) {
    $mdSidenav(menuId).toggle();
  };

  $scope.badanie = 
  {
      liczbaOperatorow: '',
      liczbaCech: '',
      liczbaProduktow: '',
      liczbaPowtorzen: '',
      tytul: '',
      nazwaFirmy: '',
      odpowiedzialny: '',
      klient: '',
      proces: '',
      stanowisko: '',
      nazwaCzesci: '',
  }


  var list = [];
  for (var i = 0; i < 100; i++) {
    list.push({
      name: 'List Item ' + i,
      idx: i
    });
  }
  $scope.list = list;
}]);