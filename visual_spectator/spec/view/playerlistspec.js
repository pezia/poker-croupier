define(['view/playerlist', 'collection/player'], function(PlayerListView, PlayerCollection) {
    describe('PlayerListView', function() {
        it('should display list of players', function() {
            var players = [{name: 'John', order: 1}, {name: 'David', order: 2}];
            var collection = new PlayerCollection(players);
            var view = new PlayerListView({collection: collection});

            view.render();

            expect(view.$('.panel-heading').length).toEqual(2);
        });
    });
});