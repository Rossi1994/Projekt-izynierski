var a = angular.module('BlankApp', ['ngRoute','ngTouch', 'ui.select', 'ngMaterial', 'ui.grid', 'ui.grid.pinning', 'ui.grid.cellNav', 'ui.grid.edit'])
 .controller('app', app)
 .controller('AppCtrl', AppCtrl)
  .directive('uiSelectWrap', uiSelectWrap)
    .factory('myService', function () {
        var SaveData = {}

        function set(data) {
            SaveData = data;
        }
        function get() {
            return SaveData;
        }

        return {
            set : set,
            get: get
        }

    })
     .factory('spreadSheetDataFactory', function () {
         var SaveData = {}

         function set(data) {
             SaveData = data;
         }
         function get() {
             return SaveData;
         }

         return {
             set: set,
             get: get
         }

     })
.config(['$routeProvider', function ($routeProvider) {
    $routeProvider
        .when('/', {
            templateUrl: 'start.html',
            controller: 'Spr'
        })
      .when('/arkusz', {
          templateUrl: 'arkusz.html',
          controller: 'Spr'
      })
      .when('/login', {
          templateUrl: 'login.html',
          controller: 'Spr'
      })
         .when('/material', {
             templateUrl: 'material.html',
             controller: 'app'
         })
      .when('/user', {
          templateUrl: 'user.html',
          controller: 'Spr'
      })
     .when('/registration', {
         templateUrl: 'register.html',
         controller: 'Spr'
     })
     .when('/traits', {
         templateUrl: 'traits.html',
         controller: 'traitsController'
     })
    

       
}])




a.controller('traitsController', ['$scope', 'spreadSheetDataFactory', function ($scope, spreadSheetDataFactory) {
   

    $scope.spreadSheetDataFactory = spreadSheetDataFactory;
     var data = [];
     $scope.cechy = [];
     $scope.operatorzy = [];
     $scope.przedmioty = [];

    $scope.temporaryTraits = data;

    
    $scope.dodajCeche = function (cecha) {
        $scope.temporaryTraits.push(cecha);
        $scope.cechy.push(cecha);
    }

    $scope.dodajPrzedmiot = function (przedmiot) {
        $scope.przedmioty.push(przedmiot);
    }
    $scope.dodajOperatora = function (operator) {
        $scope.operatorzy.push(operator);
    }

    $scope.dalej = function () {
        spreadSheetDataFactory.set(
            {
                operatorzy: $scope.operatorzy,
                przedmioty: $scope.przedmioty,
                cechy: $scope.cechy
            });
    }

}]);


a.controller('Dialog', function ($scope, $mdDialog, $mdMedia, myService) {
    $scope.status = '  ';
    $scope.customFullscreen = $mdMedia('xs') || $mdMedia('sm');


    $scope.dodajCeche = function () {
       

    }

    
    $scope.showAdvanced = function (ev) {
        var useFullScreen = ($mdMedia('sm') || $mdMedia('xs')) && $scope.customFullscreen;
        $mdDialog.show({
            controller: DialogController,
            templateUrl: 'dialog1.tmpl.html',
            parent: angular.element(document.body),
            targetEvent: ev,
            clickOutsideToClose: true,
            fullscreen: useFullScreen
        })
        .then(function (answer) {
            $scope.status = 'You said the information was "' + answer + '".';
        }, function () {
            $scope.status = 'You cancelled the dialog.';
        });
        $scope.$watch(function () {
            return $mdMedia('xs') || $mdMedia('sm');
        }, function (wantsFullScreen) {
            $scope.customFullscreen = (wantsFullScreen === true);
        });
    };
    
    $scope.showTabDialog = function (ev) {
        $mdDialog.show({
            controller: DialogController,
            templateUrl: 'tabDialog.html',
            parent: angular.element(document.body),
            targetEvent: ev,
            clickOutsideToClose: false
        })

    };
});
function DialogController($scope, $mdDialog) {
    $scope.hide = function () {
        $mdDialog.hide();
    };
    $scope.cancel = function () {
        $mdDialog.cancel();
    };
    $scope.answer = function (answer) {
        $mdDialog.hide(answer);
    };
}



a.controller('Spr', ['$scope', '$mdSidenav', 'myService' , function ($scope, $mdSidenav, myService) {
    //button//
    $scope.UAMUrl = 'http://amu.edu.pl';
    $scope.WMIUrl = 'http://wmi.amu.edu.pl';
    $scope.loginUrl = '#login';
    $scope.userUrl = '#user';
    $scope.arkuszUrl = '#arkusz';
    $scope.arkUrl = '#material';
    $scope.registryUrl = '#register';
    $scope.smod = '#smod';
    
    $scope.badanie =
        {



        }


    $scope.zlecBadanie = function () {
  myService.set($scope.badanie);
      };


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





app.$inject = ['$scope', '$log', '$http', 'myService', 'spreadSheetDataFactory'];
function app($scope, $log, $http, myService, spreadSheetDataFactory) {


    var spreadSheetData = spreadSheetDataFactory.get();

      $scope.label = 'tytuł: ' + myService.get().tytul + 'nazwaFirmy: ' + myService.get().nazwaFirmy +
    'klient: ' + myService.get().klient + 'proces: ' + myService.get().proces + 'stanowisko: ' + myService.get().stanowisko +
      ' nazwaCzesci: ' + myService.get().nazwaCzesci;




        $scope.operatorzy = spreadSheetData.operatorzy;
        $scope.zmienna = "wartoscZmiennej";
        var data1 = [{}];
       // var data2 = [{}];

       
        for (var i = 0; i < spreadSheetData.przedmioty.length; i++) {
            data1[i] = { "id": "" + (i + 1), "name": spreadSheetData.przedmioty[i] };
        };

    /*
        for (var i = 0; i < 30; i++) {
            if (i % 2) {
                data1[i] = { "id": "" + (i + 1), "name": "PenX" + "ballPoint" }
            }
            else {
                data1[i] = { "id": "" + (i + 1), "name": "PenX" + "Sharp" }
            }

        }
        */
    

        var cechy = [];

        for (var i = 0; i < spreadSheetData.cechy.length ; i++) {
            cechy.push({
                name: spreadSheetData.cechy[i],
                enableColumnResizing: true, editableCellTemplate: 'uiSelect.html',
                editDropdownOptionsArray: [
           'too shiny',
           'too dull',
           'perfect'
                ]

            } );
        }


        $scope.gridOptions = {
            columnDefs: [
           { name: 'id', type: 'number', width: 100, pinnedLeft: true, enableCellEditOnFocus: false, enableColumnResizing: true },
           { name: 'name', width: 150, pinnedLeft: true, enableCellEditOnFocus: false, enableColumnResizing: true },
           {
               name: 'Kolor', enableColumnResizing: true, editableCellTemplate: 'uiSelect.html',
               editDropdownOptionsArray: [
          'Zbyt Jasny',
          'zbyt ciemny',
          'idealny'
               ]
           },

        {
            name: 'Werdykt',
            width: 400,
            pinnedRight: true,
            editableCellTemplate: 'uiSelect.html',
            editDropdownOptionsArray: [
            'Nie nadaje sie',
            'Ledwie się nadaje',
			'Idealny'
            ]
        }
            ].concat(cechy)


        };


        $scope.addColumn = function (n, opcja1, opcja2) {
            $scope.gridOptions.columnDefs.push(
                {
                    name: n,
                    enableColumnResizing: true,
                    editableCellTemplate: 'uiSelect.html',
                    editDropdownOptionsArray: [
                    opcja1,
                    opcja2
                    ]


                })

        }

        $scope.dane = {};

        $scope.iter = 0;

        //$scope.gridOptions.columnDefs.push(myService.get());


     

        $scope.removeRow = function (id) {
            $scope.gridOptions.data.splice((id - 1 - $scope.iter), 1);
            $scope.iter = $scope.iter + 1;
        }

        $scope.swapData = function (index) {
            if (index % 2 === 0) {
                $scope.gridOptions.data = data2
            } else {
                $scope.gridOptions.data = data1
            }
            $scope.iter = $scope.iter + 1;
        }

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



AppCtrl.$inject = ['$scope', '$log', 'myService'];
function AppCtrl($scope, $log, myService) {



    var tabs = [
          {
              title: '1 Rafał Maskowski',
              hasContent : false
          },
          {
              title: '2 Jan Kowalski',
              hasContent: false
          }
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



