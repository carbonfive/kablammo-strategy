require './aggressive'
require './defensive'

include Aggressive
include Defensive

on_turn do
  rand > 0.5 ? act_aggressively : act_defensively
end
