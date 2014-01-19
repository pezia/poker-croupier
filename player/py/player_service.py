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
     
class PlayerHandler:

  def name(self):
    return "Peter Python"

  def competitor_status(self, competitor):
    pass

  def hole_card(self, card):
    pass

  def community_card(self, card):
    pass

  def bet(self, competitor, bet):
    pass

  def bet_request(self, pot, limits):
    return 0

  def showdown(self, comptetior, cards, hand):
    pass

  def winner(self, competitor, amount):
    pass

  def shutdown(self):
      sys.exit('Shutting down server')

handler = PlayerHandler()
processor = PlayerStrategy.Processor(handler)
transport = TSocket.TServerSocket('localhost', 30303)
tfactory = TTransport.TBufferedTransportFactory()
pfactory = TBinaryProtocol.TBinaryProtocolFactory()

server = TServer.TSimpleServer(processor, transport, tfactory, pfactory)

print "Starting python server..."
server.serve()
print "done!"
