
notesApp.controller('NotesCtrl', function($scope, $http, $location, $filter) {
  $('.dropdown-button').dropdown({
    inDuration: 300,
    outDuration: 225,
    constrainWidth: false, // Does not change width of dropdown to that of the activator
    hover: true, // Activate on hover
    gutter: 0, // Spacing from edge
    belowOrigin: false, // Displays dropdown below the button
    alignment: 'left', // Displays dropdown with edge aligned to the left of button
    stopPropagation: false // Stops event propagation
  });

   console.log('pollo',$location.$$absUrl.split("/")[4]);
  $scope.selected={
    client:null,
    furnishing: null,
  };
  
  $scope.listado ={
    furnitures:[]
  };

  $scope.fertilizer ={
    assets:false,
    deadlines:[],
    selectedDeadlines:{}
    
  };

  function getListado() {
   var id = $location.$$absUrl.split("/")[4]
    $http.get('/sales/getFurnitureSale?id='+ id)
    .then(function(response) {
      $scope.listado=response.data;
       var furnitures = response.data.furnitures;
       var sale = response.data.sale;
       var lineFurnitures= response.data.lineFurnitures;
       lineFurnitures.forEach(function(element) {
         element.furniture_id= $filter('filter')($scope.listado.furnitures, {id: element.furniture_id}, true)[0]
       });
       var compone ={
        sale: sale
       }
    });
  }


  $scope.showdetails = function(fish_id) {
    var found = $filter('filter')($scope.listado.furnitures, {id: fish_id}, true);
    if (found.length) {
        $scope.selected = JSON.stringify(found[0]);
    } else {
        $scope.selected = 'Not found';
    }
}

  function addItem(furnishing) {
   console.log(furnishing.originalObject.id, 'en la funcion');
   var id = furnishing.originalObject.id;
   var idSale = $location.$$absUrl.split("/")[4]
    $http.get('/sales/add_item?id='+1+'&saleid='+idSale)
    .then(function(response) {
        $scope.myWelcome = response.data;
        getListado();
    });
  }

  function addClient(client) {
    var idSale = $location.$$absUrl.split("/")[4]
     $http.get('/sales/setClient?id='+idSale+'&clientId='+client.id)
     .then(function(response) {
      console.log(response)
     });
   }


   function getDeadlines() {
    var idSale = $location.$$absUrl.split("/")[4]
     $http.get('/sales/getDeadlines?id='+idSale)
     .then(function(response) {
       $scope.fertilizer.deadlines =response.data
     });
   }


  $scope.saleNex = function() {
    if(!$scope.selected.client){
      Materialize.toast('Tine que tener cliente', 4000)
      return
    }
    if(!$scope.listado.furnitures){
      Materialize.toast('Tine que tener productos', 4000)
      return
    }
    addClient($scope.selected.client.originalObject);
    $scope.fertilizer.assets = true
    getDeadlines();
  };

  $scope.selecDeadlines = function(deadlines) {
    $scope.fertilizer.selectedDeadlines = deadlines;
  };

  $scope.insertinvited = function(user) {
    if(user.isChecked) {
      $scope.invited.push(user.name);
    } else {
      var toDel = $scope.invited.indexOf(user);
      $scope.invited.splice(toDel);
    }
  }
    



getListado();
  
  
$scope.greeting = 'hello world';
$scope.addfurnishing = function (furnishing) {
  var name = angular.element($('#productoIput_value'));
  document.getElementById('productoIput_value').value='';
  addItem(furnishing);
};



});