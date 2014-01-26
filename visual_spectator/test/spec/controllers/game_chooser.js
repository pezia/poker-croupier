
'use strict';

describe('Controller: GameChooserCtrl', function() {

    // load the controller's module
    beforeEach(module('visualSpectatorApp'));

    var GameChooserCtrl,
            scope;

    // Initialize the controller and a mock scope
    beforeEach(inject(function($controller, $rootScope) {
        scope = $rootScope.$new();
        GameChooserCtrl = $controller('GameChooserCtrl', {
            $scope: scope
        });
    }));

    it('should have games in the scope', function() {
        expect(scope.games).toBe('array');
    });
});
