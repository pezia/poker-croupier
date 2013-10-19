define(['marionette', 'underscore', 'text!../template/player.html'], function(Marionette, _, html) {
    return Marionette.ItemView.extend({
        className: 'panel panel-default player-panel',
        template: _.template(html),

        onRender: function()
        {
            this.$el.attr('id', 'player' + this.model.get('order'));
        }
    });
});