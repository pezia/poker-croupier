#!/usr/bin/env python
 
import sys
sys.path.append('./lib/api')
  
from player_strategy import PlayerStrategy
from player_strategy.ttypes import *
   
from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol
from thrift.server import TServer
    
import socket

from lib.handler import PlayerHandler

handler = PlayerHandler()
processor = PlayerStrategy.Processor(handler)
transport = TSocket.TServerSocket('localhost', 30303)
tfactory = TTransport.TBufferedTransportFactory()
pfactory = TBinaryProtocol.TBinaryProtocolFactory()

server = TServer.TSimpleServer(processor, transport, tfactory, pfactory)

print "Starting python server..."
server.serve()
print "done!"
