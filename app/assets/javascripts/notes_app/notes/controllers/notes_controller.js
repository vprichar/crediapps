notesApp.controller('NotesCtrl', function($scope) {
$scope.greeting = 'hello world';
$scope.alertGreeting = function () {
    alert($scope.greeting);
};

});