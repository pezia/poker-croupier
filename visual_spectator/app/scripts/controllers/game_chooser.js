'use strict';

angular.module('visualSpectatorApp')
        .controller('GameChooserCtrl', function($scope) {
            $scope.games = [
                {
                    'name': 'game_2014_01_25_17_08_45',
                    'url': '../log/game_2014_01_25_17_08_45.json'
                },
                {
                    'name': 'game_2014_01_25_17_19_40',
                    'url': '../log/game_2014_01_25_17_19_40.json'
                }
            ];
        });
