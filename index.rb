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

channel = ARGV[0]
capsule = RedisMessageCapsule.capsule

send_channel = capsule.channel "#{channel}-send"
receive_channel = capsule.channel "#{channel}-receive"

def next_turn(channel, args)
  battle = Strategy::Model::Battle.new args
  Strategy::Strategy.new.execute_turn channel, battle
end

puts "Welcome to Kablammo, #{channel}!"
receive_channel.register do |msg|
  turn = next_turn channel, msg
  send_channel.send turn
end

sleep
