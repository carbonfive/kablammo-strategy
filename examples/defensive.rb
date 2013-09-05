module Defensive
  def dance
    first_possible_move %w(n s e w).shuffle
  end

  def dodge(enemy)
    am = moves_toward enemy
    d1 = enemy.square.distance_to robot.square_for(am[1])
    d2 = enemy.square.distance_to robot.square_for(am[2])
    if d1 > d2
      moves = [ am[1], am[2], am[3], am[0] ]
    else
      moves = [ am[2], am[1], am[3], am[0] ]
    end
    first_possible_move moves
  end

  def act_defensively
    enemy = opponents.first
    return dance unless enemy
    return dodge enemy if enemy.can_fire_at? me
    return rest unless my.ammo_full?
    move_away_from! enemy
  end
end
