package com.devillsroom.poker.player;

import org.junit.Test;

import java.io.IOException;

public class PlayerServiceTest {

    @Test
    public void testStart2Players() throws InterruptedException, IOException {

        startPlayerThread("Java Player 1", 9200);
        startPlayerThread("Java Player 2", 9201);

        System.out.println(execCmd("bundle exec ruby ../../croupier/scripts/integration_test_external_players.rb"));
    }

    public static String execCmd(String cmd) throws java.io.IOException {
        Process p = Runtime.getRuntime().exec(cmd);
        java.util.Scanner s = new java.util.Scanner(p.getErrorStream()).useDelimiter("\\A");
        return s.hasNext() ? s.next() : "";
    }

    private void startPlayerThread(String name, int port) throws InterruptedException {
        Thread t = new Thread(new PlayerService(name, port));
        t.start();
    }


}
