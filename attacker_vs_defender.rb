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
    return
  elsif defender_armies <= 0
    puts "Defender has no armies and can't defend."
    puts "Attacker wins by default."
    return
  end

  if attacker_armies >= 3
    attack_dice = [Die.new, Die.new, Die.new]
  else
    attack_dice = []
    attack_armies.times { attack_dice << Die.new }
  end

  if defender_armies >= 2
    defend_dice = [Die.new, Die.new]
  else
    defined_dice = [Die.new]
  end

  puts "New Battle Begins!"
  puts "=================="
  puts
  puts "Attacker #{attacker_armies} armies"
  puts "Defender #{defender_armies} armies"
  puts
end
