package com.devillsroom.poker.player;

import com.devillsroom.poker.client.*;
import org.apache.thrift.TException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

public class PlayerStrategyHandler implements PlayerStrategy.Iface {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public String name;

    public PlayerStrategyHandler(String name) {
        this.name = name;
    }

    @Override
    public String name() throws TException {
        return name;
    }

    @Override
    public long bet_request(long pot, BetLimits limits) throws TException {
        logger.debug("bet_request");

        return 0;
    }

    @Override
    public void competitor_status(Competitor competitor) throws TException {
        logger.debug("competitor_status");
    }

    @Override
    public void bet(Competitor competitor, Bet bet) throws TException {
        logger.debug("bet");

    }

    @Override
    public void hole_card(Card card) throws TException {
        logger.debug("hole_card");

    }

    @Override
    public void community_card(Card card) throws TException {
        logger.debug("community_card");

    }

    @Override
    public void showdown(Competitor competitor, List<Card> cards, HandDescriptor hand) throws TException {
        logger.debug("showdown");

    }

    @Override
    public void winner(Competitor competitor, long amount) throws TException {
        logger.debug("winner");

    }

    @Override
    public void shutdown() throws TException {
        logger.debug("shutdown");

    }
}
