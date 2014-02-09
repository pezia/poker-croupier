'use strict';

angular.module('visualSpectatorApp').directive('card', function() {
    return {
        restrict: 'E',
        templateUrl: 'views/card.html',
        replace: true,
        scope: {
            card: '='
        }
    };
});
