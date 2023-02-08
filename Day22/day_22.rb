Enemy = Struct.new(:hit_points, :damage)

class Player
  attr_accessor :hit_points,
                :mana_points,
                :shield_turns_left,
                :poison_turns_left,
                :recharge_turns_left,
                :mana_points_spent,
                :rounds_elapsed

  def initialize(hit_points:, mana_points:)
    @hit_points = hit_points
    @mana_points = mana_points
    @shield_turns_left = 0
    @poison_turns_left = 0
    @recharge_turns_left = 0
    @mana_points_spent = 0
    @rounds_elapsed = 0
  end

  def armor
    @shield_turns_left > 0 ? 7 : 0
  end

  def available_actions
    return nil if @mana_points < 53

    # Improve runtime by culling potential very slow battle plans
    return nil if @rounds_elapsed > 12

    actions = [:magic_missile]
    actions << :drain if @mana_points >= 73
    actions << :shield if @mana_points >= 113 && @shield_turns_left == 0
    actions << :poison if @mana_points >= 173 && @poison_turns_left == 0
    actions << :recharge if @mana_points >= 229 && @recharge_turns_left == 0

    actions
  end

  def cast_spell(spell, enemy)
    @rounds_elapsed += 1

    if spell == :magic_missile
      @mana_points -= 53
      @mana_points_spent += 53
      enemy.hit_points -= 4
    elsif spell == :drain
      @mana_points -= 73
      @mana_points_spent += 73
      @hit_points += 2
      enemy.hit_points -= 2
    elsif spell == :shield
      @mana_points -= 113
      @mana_points_spent += 113
      @shield_turns_left = 6
    elsif spell == :poison
      @mana_points -= 173
      @mana_points_spent += 173
      @poison_turns_left = 6
    else # :recharge
      @mana_points -= 229
      @mana_points_spent += 229
      @recharge_turns_left = 5
    end
  end

  def apply_start_of_turn_effects(enemy)
    if @shield_turns_left > 0
      @shield_turns_left -= 1
    end

    if @poison_turns_left > 0
      enemy.hit_points -= 3
      @poison_turns_left -= 1
    end

    if @recharge_turns_left > 0
      @mana_points += 101
      @recharge_turns_left -= 1
    end
  end
end

def unmitigated_damage(damage, armor)
  result = damage - armor
  [result, 1].max
end

def read_boss_enemy
  data = File.readlines('input.txt')
  Enemy.new(data[0][12..].to_i, data[1][8..].to_i)
end

def least_mana_spent_in_victory(player, enemy, difficulty)
  # Player turn
  if difficulty == :hard
    player.hit_points -= 1
    return Float::INFINITY if player.hit_points <= 0
  end

  player.apply_start_of_turn_effects(enemy)

  return player.mana_points_spent if enemy.hit_points <= 0

  available_actions = player.available_actions

  return Float::INFINITY if available_actions.nil?

  minimum_mana_spent_in_victory = Float::INFINITY
  available_actions.each do |action|
    p = player.clone
    e = enemy.clone

    p.cast_spell(action, e)

    # Boss turn
    p.apply_start_of_turn_effects(e)

    if e.hit_points <= 0
      minimum_mana_spent_in_victory = p.mana_points_spent if p.mana_points_spent < minimum_mana_spent_in_victory
      next
    end

    p.hit_points -= unmitigated_damage(e.damage, p.armor)

    if p.hit_points <= 0
      next
    end

    # Next round
    minimum_mana_eventually_spent_in_victory = least_mana_spent_in_victory(p, e, difficulty)
    minimum_mana_spent_in_victory = minimum_mana_eventually_spent_in_victory if minimum_mana_eventually_spent_in_victory < minimum_mana_spent_in_victory
  end

  minimum_mana_spent_in_victory
end

enemy = read_boss_enemy
player = Player.new(hit_points: 50, mana_points: 500)

p least_mana_spent_in_victory(player, enemy, :normal)
