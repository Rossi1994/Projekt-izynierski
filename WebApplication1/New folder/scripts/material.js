var a = angular.module('BlankApp', ['ngCookies','ngTouch', 'ui.select', 'ngMaterial', 'ui.grid', 'ui.grid.pinning', 'ui.grid.cellNav', 'ui.grid.edit'])
 .controller('app', app)
 .controller('AppCtrl', AppCtrl)
  .directive('uiSelectWrap', uiSelectWrap)
    .factory('myService', function () {
        var savedData = {}
    function set(data) {
        savedData = data;
    }
    function get() {
        return savedData;
    }

    return {
        set: set,
        get: get
    }

    });

a.controller('Dialog', function($scope, $mdDialog, $mdMedia, myService, $cookies) {
    $scope.status = '  ';
    $scope.customFullscreen = $mdMedia('xs') || $mdMedia('sm');
    

    $scope.dodajCeche = function () {
        $cookies.put("k", "pleple");

    }
   

    $scope.showAdvanced = function(ev) {
        var useFullScreen = ($mdMedia('sm') || $mdMedia('xs'))  && $scope.customFullscreen;
        $mdDialog.show({
            controller: DialogController,
            templateUrl: 'dialog1.tmpl.html',
            parent: angular.element(document.body),
            targetEvent: ev,
            clickOutsideToClose:true,
            fullscreen: useFullScreen
        })
        .then(function(answer) {
            $scope.status = 'You said the information was "' + answer + '".';
        }, function() {
            $scope.status = 'You cancelled the dialog.';
        });
        $scope.$watch(function() {
            return $mdMedia('xs') || $mdMedia('sm');
        }, function(wantsFullScreen) {
            $scope.customFullscreen = (wantsFullScreen === true);
        });
    };
    $scope.showTabDialog = function(ev) {
        $mdDialog.show({
            controller: DialogController,
            templateUrl: 'tabDialog.html',
            parent: angular.element(document.body),
            targetEvent: ev,
            clickOutsideToClose:false
        })
            .then(function(answer) {
                $scope.status = 'You said the information was "' + $cookies.get('k') + '".';
            }, function() {
                $scope.status = $cookies.get('k');
            });
    };
});
function DialogController($scope, $mdDialog) {
    $scope.hide = function() {
        $mdDialog.hide();
    };
    $scope.cancel = function() {
        $mdDialog.cancel();
    };
    $scope.answer = function(answer) {
        $mdDialog.hide(answer);
    };
}




a.controller('Spr', ['$scope', '$mdSidenav', 'myService','$cookies', function ($scope, $mdSidenav, myService,$cookies) {
    //button//
    $scope.UAMUrl = 'http://amu.edu.pl';
    $scope.WMIUrl = 'http://wmi.amu.edu.pl';
    $scope.loginUrl = 'login.html';
    $scope.userUrl = 'user.html';
    $scope.arkuszUrl = 'arkusz.html';
    //$scope.arkUrl = 'material.html'


    $scope.badanie = 
    {
        liczbaOperatorow: '',
        liczbaCech: '',
        liczbaProduktow: '',
        liczbaPowtorzen: '',
        tytul: '',
        nazwaFirmy: 'sadadsadsadasdasdddddddddd',
        odpowiedzialny: '',
        klient: '',
        proces: '',
        stanowisko: '',
        nazwaCzesci: '',
        nazwaElementu:''
    }

    
    $scope.zlecBadanie = function () {
        // myService.set($scope.badanie.nazwaFirmy);
        $cookies.put("key", "dadasdasd");
    }


    //layout//
    $scope.toggleSidenav = function (menuId) {
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


app.$inject = ['$scope', '$log', 'myService', '$cookies'];
function app($scope, $log, myService, $cookies) {


    var data1 = [{}];

    for (var i = 1; i <= 50; i++) {
        if (i % 2) {
            data1[i] = { "id": "" + i, "name": "PenX" + "ballPoint" }
        }
        else {
            data1[i] = { "id": "" + i, "name": "PenX" + "Sharp" }
        }

    }

  
    $scope.gridOptions = {
        columnDefs: [
       { name: 'id', type:'number',width: 100, pinnedLeft: true, enableCellEditOnFocus: false, enableColumnResizing: true },
       { name: 'name', width: 150, pinnedLeft: true, enableCellEditOnFocus: false, enableColumnResizing: true },
       {
           name: 'Colour', enableColumnResizing: true, editableCellTemplate: 'uiSelect.html',
                 editDropdownOptionsArray: [
            'too shiny',
            'too dull',
            'perfect'
           ]
       },
    
    {
        name: 'Verdict',
        width: 400,
        pinnedRight: true,
        editableCellTemplate: 'uiSelect.html',
        editDropdownOptionsArray:[
        'bad',
        'good'
        ]
    }
        ]


    };

    
    $scope.gridOptions.data = data1;
}
uiSelectWrap.$inject = ['$document', 'uiGridEditConstants'];
function uiSelectWrap($document, uiGridEditConstants) {
    return function link($scope, $elm, $attr) {
        $document.on('click', docClick);

        function docClick(evt) {
            if ($(evt.target).closest('.ui-select-container').size() === 0) {
                $scope.$emit(uiGridEditConstants.events.END_CELL_EDIT);
                $document.off('click', docClick);
            }
        }
    };
}

app.filter('mapTrait', function () {
    var genderHash = {
        1: 'good',
        2: 'bad'
    };

    return function (input) {
        if (!input) {
            return '';
        } else {
            return genderHash[input];
        }
    };
})


AppCtrl.$inject = ['$scope', '$log', 'myService', '$cookies'];
function AppCtrl($scope, $log, myService, $cookies) {



    var tabs = [
          {
              title:  'tastsa',
              content: "sadasda"
          },
          { title: '2 Jan Kowalski', content: "Turbo Pen2000" },
    ],
        selected = null,
        previous = null;
    $scope.tabs = tabs;
    $scope.selectedIndex = 2;
    $scope.$watch('selectedIndex', function (current, old) {
        previous = selected;
        selected = tabs[current];
        if (old + 1 && (old != current)) $log.debug('Goodbye ' + previous.title + '!');
        if (current + 1) $log.debug('Hello ' + selected.title + '!');
    });
    $scope.addTab = function (title, view) {
        view = view || title + " Content View";
        tabs.push({ title: title, content: view, disabled: false });
    };
    $scope.removeTab = function (tab) {
        var index = tabs.indexOf(tab);
        tabs.splice(index, 1);
    };



}



