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


def battle_losses(attack_results, defend_results)
  attacker_losses = 0
  defender_losses = 0
  attack_results.sort!
  defend_results.sort!
  while attack_results.count > 0 && defend_results.count > 0
    attack_roll = attack_results.pop
    defend_roll = defend_results.pop
    if attack_roll > defend_roll
      defender_losses += 1
    else
      attacker_losses += 1
    end
  end
  return [attacker_losses, defender_losses]
end



attacker_losses_total = 0
defender_losses_total = 0

puts "Attack | Def"
puts "------------"
Die.new.permutations(5).each do |perm|
  attacker_losses_total += battle_losses(perm[0, 3], perm[3, 2]).first
  defender_losses_total += battle_losses(perm[0, 3], perm[3, 2]).last
  puts "#{perm[0]} #{perm[1]} #{perm[2]} vs #{perm[3]} #{perm[4]}"
end
puts
puts "Final Outcome"
puts "============="
puts "Attacker lost #{attacker_losses_total} armies."
puts "Defender lost #{defender_losses_total} armies."
puts
puts "For every 100 armies the attacker loses, the defender loses #{100 * defender_losses_total / attacker_losses_total} armies."
