"use strict"
var app = angular.module('BlankApp', ['ngMaterial', 'ngMessages']);
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
    self.fruitNames = ['Apple', 'Banana', 'Orange'];
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

    // Lists of fruit names and Vegetable objects
    self.fruitNames = ['Apple', 'Banana', 'Orange'];
    self.roFruitNames = angular.copy(self.fruitNames);
    self.editableFruitNames = angular.copy(self.fruitNames);

    self.tags = [];
    self.vegObjs = [{
            'name': 'Broccoli',
            'type': 'Brassica'
        },
        {
            'name': 'Cabbage',
            'type': 'Brassica'
        },
        {
            'name': 'Carrot',
            'type': 'Umbelliferous'
        }
    ];

    self.newVeg = function(chip) {
        return {
            name: chip,
            type: 'unknown'
        };
    };
}
})();