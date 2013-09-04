require 'rubygems'
require 'bundler'
Bundler.require 'default'

if ARGV.empty?
  puts "Usage: ruby index.rb <channel>"
  exit 1
end

require './strategy/models/base.rb'
require './strategy/base.rb'
Dir['./strategy/**/*.rb'].each { |f| require f }

Thread.abort_on_exception = true

username = ARGV[0]
capsule = RedisMessageCapsule.capsule

send_channel = capsule.channel "#{username}-send"
receive_channel = capsule.channel "#{username}-receive"

strategy = Strategy::Strategy.new username

def next_turn(strategy, args)
  battle = Strategy::Model::Battle.new args
  strategy.execute_turn battle
end

puts "Welcome to Kablammo, #{username}!"
receive_channel.register do |msg|
  turn = next_turn strategy, msg
  send_channel.send turn
end

sleep
