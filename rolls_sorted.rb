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

rolls = (1..10).map { d1.roll }
rolls.sort!.each { |roll| puts "The result of your roll is #{roll}." }
