STRATEGIES = {
  example1: [
    { x: 3, y: 1 }
  ],
  example2: [
    { x: 1, y: 1 },
    { x: 3, y: 1 },
    { x: 5, y: 1 },
    { x: 7, y: 1 },
    { x: 1, y: 2 }
  ]
}

class Map
  TREE = '#'.freeze

  def initialize
    @grid = File.read('data.txt').split("\n").map { |line| line.split('') }
  end

  def at(x, y)
    relative_x = x % width
    @grid[y][relative_x]
  end

  def tree_at?(x, y)
    at(x, y) == TREE
  end

  def length
    @grid.count
  end

  def width
    @grid.first.count
  end
end

class Journey
  def initialize(strategy)
    @x, @y = [0, 0]
    @tree_count = 0
    @map = Map.new
    @strategy = strategy
  end
  attr_reader :tree_count

  def complete
    while @y < @map.length do
      count_trees!
      move!
    end
    self
  end

  def move!
    @x += @strategy[:x]
    @y += @strategy[:y]
  end

  def count_trees!
    @tree_count += 1 if @map.tree_at?(@x, @y)
  end
end

STRATEGIES[:example1].each_with_index do |strategy, i|
  puts "Example 1.#{i}: tree count #{Journey.new(strategy).complete.tree_count}"
end

STRATEGIES[:example2].each_with_index do |strategy, i|
  puts "Example 2.#{i}: tree count #{Journey.new(strategy).complete.tree_count}"
end

product_tree_count = STRATEGIES[:example2].map do |strategy|
  Journey.new(strategy).complete.tree_count
end.inject(:*)

puts "Answer part 2: #{product_tree_count}"
