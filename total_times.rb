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

end



d1 = Die.new

d1.totals.each { |k, v| puts "#{k} occurs #{v} time#{v > 1? "s": ""}" }
