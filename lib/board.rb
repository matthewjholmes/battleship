class Board
  def initialize
  end

  def cells
    cell_hash = Hash.new(0)
    first_positions = ("A".."D").to_a#["A", "B", "C", "D"]
    second_positions = ("1".."4").to_a#["1","2", "3", "4"]
    # 4.times do
    counter = 0
    # 4.times do
    #   counter += 1
    #   arr = first_positions.reduce("1 2 3 4") do |letters, positions|
    #     cell_hash[positions.concat(letters)] = positions.concat(letters)
    #   end
    #   require "pry"; binding.pry
    # end
    arr = []
    first_positions.each do |position|
      second_positions.each do |element|
      arr << "#{position}#{element}"
      require "pry"; binding.pry
      end
    end
  end

    # hash = {
    #   "A1" => Cell.new(:key),
    #   "A2" => Cell.new(:key),
    #   "A3" => Cell.new(:key),
    #   "A4" => Cell.new(:key),
    #   "B1" => Cell.new(:key),
    #   "B2" => Cell.new(:key),
    #   "B3" => Cell.new(:key),
    #   "B4" => Cell.new(:key),
    #   "C1" => Cell.new(:key),
    #   "C2" => Cell.new(:key),
    #   "C3" => Cell.new(:key),
    #   "C4" => Cell.new(:key),
    #   "D1" => Cell.new(:key),
    #   "D2" => Cell.new(:key),
    #   "D3" => Cell.new(:key),
    #   "D4" => Cell.new(:key)
    # }
  # end
end
