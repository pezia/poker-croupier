var history = [
    {
        pot: 50,
        community_cards: [
            { rank: "A", suite: "spades" },
            { rank: "J", suite: "diamonds" },
            { rank: "K", suite: "hearts" },
            { rank: "9", suite: "clubs" },
        ],
        players: [
            {
                id: 1,
                name: "Ruby Rodney",
                stack: 1950,
                bet: 50,
                status: "active",
                dealer: true,
                hole_cards: [{ rank: 7, suite: "spades" }, { rank: "Q", suite: "hearts" }],
            },
            {
                id: 2,
                name: "PHilip Potts",
                stack: 1000,
                bet: 0,
                status: "folded",
                on_turn: true,
                hole_cards: [{ rank: "K", suite: "clubs" }, { rank: "8", suite: "diamonds" }]
            },
            {
                id: 3,
                name: "Jim Java",
                stack: 0,
                bet: 0,
                status: "out",
                hole_cards: []
            }
        ]
    }
];

$(document).ready(function() {
    function refreshCard(holecard, dom_card) {
        $(dom_card).removeClass("spades clubs hearts diamonds");
        if (holecard) {
            $(dom_card).addClass(holecard.suite);
            $(dom_card).text(holecard.rank);
        } else {
            $(dom_card).text('');
        }
    }

    function addPlayer(player) {

        function setFlagClass(flag) {
            if (player[flag]) {
                template.addClass(flag);
            } else {
                template.removeClass(flag);
            }
        }

        var template = $('#player-template').clone();

        template.id = 'player'+player.id;

        template.find('.name').text(player.name);
        template.find('.stack').text(player.stack);

        var dom_status = template.find('.status');
        dom_status.removeClass('label-danger label-success label-default');
        if(player.status === 'active') {
            dom_status.addClass('label-success');
            dom_status.text('Bet: '+player.bet+' €');
        } else if(player.status === 'folded') {
            dom_status.addClass('label-danger');
            dom_status.text('Folded');
        } else if(player.status === 'out') {
            dom_status.addClass('label-default');
            dom_status.text('Out');
        } else {
            dom_status.text('');
        }

        template.find('.hole-cards div').each(function(index, dom_card) {
            refreshCard(player.hole_cards[index], dom_card);
        });

        setFlagClass('on_turn');
        setFlagClass('dealer');
        return template;
    }

    $("#pot-amount").text(history[0].pot);

    $('#community-cards div.card').each(function(index, dom_card) {
        refreshCard(history[0].community_cards[index], dom_card);
    });

    $('#playerContainer').empty();
    history[0].players.forEach(function(player) {
        $('#playerContainer').append(addPlayer(player));
    });
});