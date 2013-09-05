require 'rubygems'
require 'bundler'
Bundler.require 'default'

if ARGV.empty?
  puts "Usage: ruby index.rb <channel> <strategy>"
  exit 1
end

require './lib/strategy'

Thread.abort_on_exception = true

username = ARGV[0]
strategy_path = if ARGV.length > 1
                  ARGV[1]
                else
                  'strategy.rb'
                end
strategy_path = File.join(Dir.pwd, strategy_path)
capsule = RedisMessageCapsule.capsule

send_channel = capsule.channel "#{username}-send"
receive_channel = capsule.channel "#{username}-receive"

strategy = Strategy::Base.new username
strategy.load strategy_path

def next_turn(strategy, args)
  battle = Strategy::Model::Battle.new args
  strategy.execute_turn battle
end

redis = Redis.new
redis.del send_channel
redis.del receive_channel

puts "Welcome to Kablammo, #{username}!"
receive_channel.register do |msg|
  turn = next_turn strategy, msg
  send_channel.send turn
end

sleep
