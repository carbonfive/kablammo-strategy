require './examples/aggressive'
require './examples/defensive'

on_startup do
  @chooser = Proc.new do
    factors = { mwynholds: 0.8, carbonfive: 0.5, dhendee: 0.2 }
    factor = factors[username.to_sym] || 0.5
    rand() <= factor ? Aggressive.new(username) : Defensive.new(username)
  end
end

on_turn do
  strategy = @chooser.call
  strategy.for_use_by self
  strategy.next_turn
end
