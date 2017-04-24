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

puts "The result of your roll is #{d1.roll}."
