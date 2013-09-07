# this will also be deleted before launch
# (it will be auto-generated when creating a new battle)
# Strategy Developers shouldn't have access to this code
# if you need to make changes:
# be sure to update both this file and its source in the kablamo repo
# source can be found at:
# https://github.com/carbonfive/kablammo/tree/master/app/assets/process/spawn.player.rb

def usage
  puts "Usage: ruby index.rb <channel> <strategy>"
  exit 1
end

usage if ARGV.empty?
username = ARGV[0]

require 'rubygems'
require 'bundler'
Bundler.require 'default'

require './lib/index'

require './player.rb'

strategy = Player.load_strategy username

raise "Player.load_strategy must return a Strategy not a #{strategy.class.name}!" unless strategy.kind_of? Strategy::Base
def next_turn(strategy, args)
  battle = Strategy::Model::Battle.new args
  strategy.execute_turn battle
end

capsule = RedisMessageCapsule.capsule
send_channel = capsule.channel "#{username}-send"
receive_channel = capsule.channel "#{username}-receive"

send_channel.clear
receive_channel.clear
Thread.abort_on_exception = true

process = Thread.current

receive_channel.register do |msg|
  if 'shutdown'.eql? msg
    process[:shutdown] = true
    Thread.exit
  end
  turn = next_turn strategy, msg
  send_channel.send turn
end

puts "Welcome to Kablammo, #{username}!"

begin
  while !process[:shutdown] do
    sleep 1
  end
rescue SignalException => e
  puts
  puts 'Quit'
end
puts "Game Over for #{username}"