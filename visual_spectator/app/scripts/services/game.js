'use strict';

angular.module('visualSpectatorApp').factory('Game', ['$resource',
    function($resource) {
        return $resource('../../log/:gameName.json', {}, {
            get: {method: 'GET', params: {gameName: 'gameName'}, isArray: true}
        });
    }]);