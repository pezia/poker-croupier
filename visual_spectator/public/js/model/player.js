define(['backbone'], function(Backbone) {
    return Backbone.Model.extend({
        defaults: {
            name: '',
            order: 0
        }
    })
});