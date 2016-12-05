"use strict"
var app = angular.module('BlankApp', ['ngMaterial', 'ngMessages', 'ngAnimate']);
app.config(['$mdIconProvider', function($mdIconProvider) {
    $mdIconProvider.icon('md-close', 'img/icons/ic_close_24px.svg', 24);
}])
app.controller('AppCtrl', ['$scope', '$mdSidenav', function($scope, $mdSidenav) {
    //button//
    $scope.UAMUrl = 'http://amu.edu.pl';
    $scope.WMIUrl = 'http://wmi.amu.edu.pl';
    $scope.loginUrl = 'login.html';
    $scope.userUrl = 'user.html';
    $scope.arkuszUrl = 'arkusz.html';
    $scope.registryUrl = 'registry.html';
    $scope.startUrl = 'start.html';
    $scope.loadUrl = 'load.html';
    //category//
    $scope.categories = [
        "Liczba operatorow",
        "Liczba cech",
        "Liczba produktow",
        "Liczba powtorzen",
        "Tytuł",
        "Nazwa firmy/wydział",
        "Odpowiedzialny",
        "Klient",
        "Proces",
        "Data",
        "Stanowisko",
        "Nazwa części",
        "Nazwa elementu"
    ];
    $scope.liczba = "<div layout-gt-sm=\"row\"><md-input-container class=\"md-block\" flex-gt-sm><label>Działa!</label><input ng-model=\"badanie.cecha\" type=\"text\"></md-input-container></div><div layout-gt-sm=\"row\"><div ng-controller=\"BasicDemoCtrl as ctrl\" layout=\"column\" ng-cloak><md-content class=\"md-padding\" layout=\"column\"><md-chips ng-model=\"ctrl.operatorzy\" readonly=\"ctrl.readonly\" md-removable=\"ctrl.removable\" md-enable-chip-edit=\"true\"></md-chips></md-content></div></div>";
    $scope.liczbaCech = 1;
    //layout//
    $scope.toggleSidenav = function(menuId) {
        $mdSidenav(menuId).toggle();
    };

    var list = [];
    for (var i = 0; i < 100; i++) {
        list.push({
            name: 'List Item ' + i,
            idx: i
        });
    }
    $scope.list = list;
}]);

function pewnosc(x) {
    if (confirm("Are you sure?") == true) {
        window.location.href = x;
    } else {}
}
app.controller('BasicDemoCtrl', DemoCtrl);

function DemoCtrl($timeout, $q) {
    var self = this;

    self.readonly = false;

    self.operatorzy = ['Andrzej Małkowski', 'Krzysztof Dyczkowski'];
};
//switch//
app.controller('ExampleController', ['$scope', function($scope) {
    $scope.items = ['1', '2', '3', '4'];
    $scope.selection = $scope.items[0];
}]);