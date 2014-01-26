'use strict';

angular.module('visualSpectatorApp', [
    'ngResource',
    'ngSanitize',
    'ngRoute'
]).config(function($routeProvider) {
    $routeProvider
            .when('/game/:gameName', {
                templateUrl: 'views/game.html',
                controller: 'GameCtrl'
            })
            .when('/', {
                templateUrl: 'views/game_chooser.html',
                controller: 'GameChooserCtrl'
            })
            .otherwise({
                redirectTo: '/'
            });
});
