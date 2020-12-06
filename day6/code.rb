groups = File.read('input.txt').split("\n\n")

anybody_yeses = groups.map do |group|
  group.split("\n").map(&:chars).flatten.uniq.size
end.sum

puts "Part 1: #{anybody_yeses}"

everybody_yeses = groups.map do |group|
  group.split("\n").map(&:chars).inject(:&).size
end.sum

puts "Part 2: #{everybody_yeses}"
