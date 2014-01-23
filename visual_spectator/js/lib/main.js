var history = [
    {
        pot: 75,
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
                stack: 975,
                bet: 25,
                status: "active",
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
    },
    {
        pot: 75,
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
                stack: 975,
                bet: 0,
                status: "folded",
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

    function render(index) {

        event = history[index];

        $("#pot-amount").text(event.pot);
        $('#community-cards div.card').each(function (index, dom_card) {
            refreshCard(event.community_cards[index], dom_card);
        });
        $('#playerContainer').empty();
        event.players.forEach(function (player) {
            $('#playerContainer').append(addPlayer(player));
        });
    }

    var currentIndex = 0;

    render(currentIndex);

    (function setUpListeners() {
        function next() { if(currentIndex < history.length - 1) { render(++currentIndex); } }
        function back() { if(currentIndex > 0) { render(--currentIndex); } }
        function beginning() { render(currentIndex = 0); }
        function end() { render(currentIndex = history.length - 1); }

        var timerHandle = false;
        function togglePlay() {
            if(!timerHandle) {
                timerHandle = setInterval(next, 1000);
                $('#play-button').text('Stop');
            } else {
                clearInterval(timerHandle);
                timerHandle = false;
                $('#play-button').text('Play');
            }
        }

        $('#next-button').click(next);
        $('#back-button').click(back);
        $('#beginning-button').click(beginning);
        $('#end-button').click(end);
        $('#play-button').click(togglePlay);

        $(window).keydown(function(e) {
            switch(e.keyCode) {
                case 37:
                    back();
                    break;
                case 39:
                    next();
                    break;
                case 36:
                    beginning();
                    break;
                case 35:
                    end();
                    break;
                case 32:
                    togglePlay()
                    break;
            }
        });
    })();
});