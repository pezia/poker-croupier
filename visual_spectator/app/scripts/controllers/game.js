'use strict';

angular.module('visualSpectatorApp').controller('GameCtrl', ['$scope', '$routeParams', 'Game', function($scope, $routeParams, Game) {
        $scope.gameStates = Game.get({gameName: $routeParams.gameName});

        $scope.currentStateIndex = 0;
        $scope.totalStates = $scope.gameStates.length;

        $scope.getGameState = function(index) {
            var state = $scope.gameStates[index % $scope.totalStates];
            state.flopCards = state.community_cards.slice(0, 3);

            if (state.community_cards.length >= 4) {
                state.turnCard = state.community_cards.slice(3, 4).pop();
            }

            if (state.community_cards.length >= 5) {
                state.riverCard = state.community_cards.slice(4, 5).pop();
            }

            return state;
        };

        $scope.currentState = $scope.getGameState($scope.currentStateIndex);

        $scope.previousState = function() {
            if ($scope.currentStateIndex > 0) {
                $scope.currentStateIndex--;
                $scope.currentState = $scope.getGameState($scope.currentStateIndex);
            }
        };

        $scope.nextState = function() {
            if ($scope.currentStateIndex < $scope.totalStates - 1) {
                $scope.currentStateIndex++;
                $scope.currentState = $scope.getGameState($scope.currentStateIndex);
            }
        };

        $scope.firstState = function() {
            $scope.currentStateIndex = 0;
            $scope.currentState = $scope.getGameState($scope.currentStateIndex);
        };

        $scope.lastState = function() {
            $scope.currentStateIndex = $scope.totalStates - 1;
            $scope.currentState = $scope.getGameState($scope.currentStateIndex);
        };
    }
]);
