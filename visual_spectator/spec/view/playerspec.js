define(['view/player', 'model/player'], function(PlayerView, PlayerModel) {
    describe('PlayerView', function() {
        it('should display players name', function() {
            var player = new PlayerModel({name: 'John Doe', order: 3});
            var view = new PlayerView({model: player});

            view.render();

            expect(view.$('.panel-title').text().indexOf('John Doe')).not.toEqual(-1);
        });

        it('should display player order as id', function() {
            var player = new PlayerModel({name: 'John Doe', order: 3});
            var view = new PlayerView({model: player});

            view.render();

            expect(view.$el.attr('id')).toEqual('player3');
        });
    });
});