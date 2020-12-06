inputs = File.read('input.txt').split("\n")
@expenses = inputs.map(&:to_i).sort

def answer(combination_length)
  @expenses.combination(combination_length).detect do |suspects|
    suspects.sum == 2020
  end.inject(:*)
end

puts "Part 1 answer: #{answer(2)}"
puts "Part 2 answer: #{answer(3)}"
