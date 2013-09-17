require './examples/aggressive'
require './examples/defensive'

extend Aggressive
extend Defensive

@chooser = Proc.new do
  rand() <= 0.5 ? act_aggressively : act_defensively
end

on_turn do
  @chooser.call
end
