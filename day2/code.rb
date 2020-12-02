@data = File.read('data.txt').split("\n")

def range(limits)
  min, max = limits.split('-').map(&:to_i)
  min..max
end

def part_1_correct_passwords
  @data.select do |row|
    limits, letter, password = row.tr(':', '').split(' ')
    occurences = password.split('').tally
    range = range(limits)
    range.cover?(occurences[letter])
  end
end

def part_2_correct_passwords
  @data.select do |row|
    limits, letter, password = row.tr(':', '').split(' ')
    characters = "_#{password}".split('')
    range = range(limits)
    [characters[range.min], characters[range.max]].one? { |char| char == letter }
  end
end

puts "Part 1: #{part_1_correct_passwords.count}"
puts "Part 2: #{part_2_correct_passwords.count}"
