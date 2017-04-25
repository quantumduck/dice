class Die
  attr_reader :sides, :showing

  def initialize(sides = 6)
    @sides = sides
    roll
  end

  def roll
    @showing = rand(@sides) + 1
  end

  def permutations(n = 2)
    (1..@sides**n).map do |permutation_number|
      permutation = []
      value = permutation_number - 1
      m = n - 1
      n.times do
        permutation << value / @sides**(m) + 1
        value %= @sides**(m)
        m -= 1
      end
      permutation
    end
  end

  def totals(n = 2)
    totals = {}
    (n..(n * @sides)).each { |sum| totals[sum] = 0 }
    permutations.each { |p| totals[p.sum] += 1 }
    totals
  end

  def odds(n = 1)
    odds = totals(n)
    num_permutations = @sides**n
    odds.each { |k, v| odds[k] = ((v * 100.0) / num_permutations).round }
    odds
  end

end

attacker_armies = 5
defender_armies = 5


def battle(attacker_armies, defender_armies)
  if attacker_armies <= 0
    puts "Attacker has no armies and can't attack."
    return [attacker_armies, defender_armies]
  elsif defender_armies <= 0
    puts "Defender has no armies and can't defend."
    puts "Attacker wins by default."
    return [attacker_armies, defender_armies]
  end

  if attacker_armies >= 3
    attack_dice = [Die.new, Die.new, Die.new]
  else
    attack_dice = []
    attacker_armies.times { attack_dice << Die.new }
  end

  if defender_armies >= 2
    defend_dice = [Die.new, Die.new]
  else
    defined_dice = [Die.new]
  end

  puts "New Battle Begins!"
  puts "=================="
  puts
  puts "Attacker: #{attacker_armies} armies"
  puts "Defender: #{defender_armies} armies"
  puts
  attack_results = attack_dice.map { |d| d.roll }
  attack_results.sort!
  result_string = attack_results.reverse.map { |r| r.to_s }.join(', ')
  puts "Attacker rolls #{result_string}"
  defend_results = defend_dice.map { |d| d.roll }
  defend_results.sort!
  result_string = defend_results.reverse.map { |r| r.to_s }.join(', ')
  puts "Devender rolls #{result_string}"
  puts
  while attack_results.count > 0 && defend_results.count > 0
    attack_roll = attack_results.pop
    defend_roll = defend_results.pop
    if attack_roll > defend_roll
      puts "Attacker wins a battle: #{attack_roll} beats #{defend_roll}"
      defender_armies -= 1
    else
      puts "Defender wins a battle: #{defend_roll} beats #{attack_roll}"
      attacker_armies -= 1
    end
    puts
    puts "Armies after the battle:"
    puts "Attacker: #{attacker_armies} armies"
    puts "Defender: #{defender_armies} armies"
    puts
    puts
    return [attacker_armies, defender_armies]
  end
end

attacker_armies = 5
defender_armies = 5
while attacker_armies > 0 && defender_armies > 0
  result = battle(attacker_armies, defender_armies)
  attacker_armies = result.first
  defender_armies = result.last
end
