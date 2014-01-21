package com.devillsroom.poker.player;

import org.junit.Test;

public class PlayerServiceTest {

    @Test
    public void testStart2Players() throws InterruptedException {

        startPlayerThread("Java Player 1", 9200, false);
        startPlayerThread("Java Player 2", 9201, true);

    }

    private void startPlayerThread(String name, int port, boolean join) throws InterruptedException {
        Thread t = new Thread(new PlayerService(name, port));
        t.start();

        if (join) {
            t.join();
        }
    }


}
