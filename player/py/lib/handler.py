import sys

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