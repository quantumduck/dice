class Die
  attr_reader :sides, :showing

  def initialize(sides = 6)
    @sides = sides
    roll
  end

  def roll
    @showing = rand(@sides) + 1
  end
end

d1 = Die.new
d2 = Die.new

puts "You rolled #{d1.roll} and #{d2.roll}."
puts "Your total is #{d1.showing + d2.showing}."
