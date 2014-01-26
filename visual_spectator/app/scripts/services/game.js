'use strict';

var gameServices = angular.module('visualSpectatorApp');

gameServices.factory('Game', ['$resource',
    function($resource) {
        return $resource('http://localhost/poker-croupier/log/:gameName.json', {}, {
            get: {method: 'GET', params: {gameName: 'gameName'}, isArray: true}
        });
    }]);