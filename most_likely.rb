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



d1 = Die.new
d1.odds(2).each { |k, v| puts "The odds of #{k} coming up are #{v}%" }
puts "#{d1.odds(2).key(d1.odds(2).values.max)} is most likely to come up with #{d1.odds(2).values.max}% chance."
