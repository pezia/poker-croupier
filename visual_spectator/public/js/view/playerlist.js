define(['marionette', './player'], function(Marionette, PlayerView) {
    return Marionette.CollectionView.extend({
        itemView: PlayerView
    });
});