module Strategy
  class Defensive < Base
    def next_turn
      enemy = find_enemies.first
      return dance unless enemy
      return dodge enemy if can_fire_at_me? enemy
      return rest unless robot.ammo_full?
      retreat_from enemy
    end
  end
end
