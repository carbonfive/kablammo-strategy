require 'rubygems'
require 'bundler'
Bundler.require 'default'

channel = ARGV[0] || 'kablammo'

capsule = RedisMessageCapsule.capsule

send_channel = capsule.channel "#{channel}-send"
receive_channel = capsule.channel "#{channel}-receive"

def next_turn
  %w(n s e w)[rand(0..4)]
end

puts "Strategy listening on channel: #{channel}"
receive_channel.register do |cmd|
  puts "Got command: #{cmd}"
  if cmd == 'next_turn'
    turn = next_turn
    send_channel.send turn
  end
end

sleep
