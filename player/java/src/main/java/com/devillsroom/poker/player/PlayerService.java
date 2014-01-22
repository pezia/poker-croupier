package com.devillsroom.poker.player;

import com.devillsroom.poker.client.PlayerStrategy;
import org.apache.thrift.server.TServer;
import org.apache.thrift.server.TSimpleServer;
import org.apache.thrift.transport.TServerSocket;
import org.apache.thrift.transport.TServerTransport;
import org.apache.thrift.transport.TTransportException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.InetAddress;
import java.net.UnknownHostException;

public class PlayerService implements Runnable {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    private String name;
    private int port;

    public static void main(String[] args) {

        new PlayerService("Java Player", 9200).run();

    }

    public PlayerService(String name, int port) {

        this.name = name;
        this.port = port;

    }

    @Override
    public void run() {

        PlayerStrategyHandler handler = new PlayerStrategyHandler(name);
        PlayerStrategy.Processor <PlayerStrategyHandler> processor = new PlayerStrategy.Processor<>(handler);

        try {
            TServerTransport serverTransport = new TServerSocket(port);
            TServer server = new TSimpleServer(new TSimpleServer.Args(serverTransport).processor(processor));

            InetAddress IP= null;
            try {
                IP = InetAddress.getLocalHost();
            } catch (UnknownHostException e) {
                e.printStackTrace();
            }

            logger.debug("Started player... " + name + " on port " + port);
            server.serve();
        } catch (TTransportException e) {
            throw new RuntimeException(e);
        }
    }

}


