Item = Struct.new(:name, :cost, :damage, :armor)
Enemy = Struct.new(:hit_points, :damage, :armor)

def initialize_items
  weapons = [
    Item.new('Dagger', 8, 4, 0),
    Item.new('Shortsword', 10, 5, 0),
    Item.new('Warhammer', 25, 6, 0),
    Item.new('Longsword', 40, 7, 0),
    Item.new('Greataxe', 75, 8, 0)
  ]
  armors = [
    Item.new('Leather', 13, 0, 1),
    Item.new('Chainmail', 31, 0, 2),
    Item.new('Splintmail', 53, 0, 3),
    Item.new('Bandedmail', 75, 0, 4),
    Item.new('Platemail', 102, 0, 5)
  ]
  rings = [
    Item.new('Damage +1', 25, 1, 0),
    Item.new('Damage +2', 50, 2, 0),
    Item.new('Damage +3', 100, 3, 0),
    Item.new('Defense +1', 20, 0, 1),
    Item.new('Defense +2', 40, 0, 2),
    Item.new('Defense +3', 80, 0, 3)
  ]
  [weapons, armors, rings]
end

def get_item_loadouts(weapons, armors, rings)
  item_loadouts = []

  weapons.each do |weapon|
    # Weapon only!
    item_loadouts << [weapon]

    armors.each do |armor|
      # Weapon + armor only (no rings)
      item_loadouts << [weapon, armor]

      rings.each_with_index do |ring_1, i|
        # Single-ring loadouts
        item_loadouts << [weapon, armor, ring_1]

        (i + 1..rings.length - 1).each do |j|
          # Two-ring loadouts
          item_loadouts << [weapon, armor, ring_1, rings[j]]
        end
      end
    end
  end

  item_loadouts
end

def read_boss_enemy
  data = File.readlines('input.txt')
  Enemy.new(data[0][12..].to_i, data[1][8..].to_i, data[2][7..].to_i)
end

def unmitigated_damage(damage, armor)
  result = damage - armor
  [result, 1].max
end

def loadout_damage(item_loadout)
  item_loadout.map(&:damage).sum
end

def loadout_armor(item_loadout)
  item_loadout.map(&:armor).sum
end

def loadout_cost(item_loadout)
  item_loadout.map(&:cost).sum
end

def is_victory?(item_loadout, boss_enemy)
  player_hit_points = 100
  boss_hit_points = boss_enemy.hit_points

  player_damage = loadout_damage(item_loadout)
  player_armor = loadout_armor(item_loadout)

  loop do
    boss_hit_points -= unmitigated_damage(player_damage, boss_enemy.armor)
    return true if boss_hit_points <= 0

    player_hit_points -= unmitigated_damage(boss_enemy.damage, player_armor)
    return false if player_hit_points <= 0
  end
end

weapons, armors, rings = initialize_items
item_loadouts = get_item_loadouts(weapons, armors, rings)
boss_enemy = read_boss_enemy

losing_loadouts = []

item_loadouts.each do |item_loadout|
  losing_loadouts << item_loadout unless is_victory?(item_loadout, boss_enemy)
end

losing_loadouts.sort_by! { |loadout| loadout_cost(loadout) }

p losing_loadouts.last
p loadout_cost(losing_loadouts.last)

