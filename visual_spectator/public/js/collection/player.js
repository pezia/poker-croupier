define(['backbone', '../model/player'], function(Backbone, PlayerModel) {
    return Backbone.Collection.extend({
        model: PlayerModel
    });
});
