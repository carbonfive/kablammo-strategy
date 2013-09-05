require './examples/aggressive'
require './examples/defensive'

extend Aggressive
extend Defensive

@chooser = Proc.new do
  factors = { mwynholds: 0.8, carbonfive: 0.5, dhendee: 0.2 }
  factor = factors[username.to_sym] || 0.5
  rand() <= factor ? act_aggressively : act_defensively
end

on_turn do
  @chooser.call
end
