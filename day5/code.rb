class BoardingPass
  BINARY_CONVERTER = {
    'F' => 0,
    'B' => 1,
    'L' => 0,
    'R' => 1
  }

  def initialize(seat_code)
    @seat_code = seat_code
  end

  def seat_id
    convert_to_binary(@seat_code.chars).to_i(2)
  end

  def convert_to_binary(letters)
    letters.map { |letter| BINARY_CONVERTER[letter] }.join('').to_s
  end
end

boarding_passes = File.read('input.txt').split("\n").map do |bp|
  BoardingPass.new(bp)
end

ordered_passes = boarding_passes.map(&:seat_id).sort
max = ordered_passes.max
min = ordered_passes.min
range = min..max

puts "Answer part 1 is: #{max}"

your_seat = (range.to_a - ordered_passes).first
puts "Answer part 2 is: #{your_seat}"
