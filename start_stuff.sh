#!/bin/bash

killall ruby
nohup bundle exec ruby player/rb/player_service.rb 9200 Haver &
nohup bundle exec ruby player/rb/player_service.rb 9201 Haver2 &
nohup bundle exec ruby ranking/ranking_service.rb  &
bundle exec ruby croupier/scripts/start.rb
php -r '$data = unserialize(file_get_contents("/tmp/poker_status"));var_dump($data);'
