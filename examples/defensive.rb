module Defensive
  def dance
    first_possible_move %w(n s e w).shuffle
  end

  def dodge(enemy)
    toward = moves_toward enemy
    d1 = enemy.distance_to robot.target_for(toward[1])
    d2 = enemy.distance_to robot.target_for(toward[2])
    if d1 > d2
      moves = [ toward[1], toward[2], toward[3], toward[0] ]
    else
      moves = [ toward[2], toward[1], toward[3], toward[0] ]
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
