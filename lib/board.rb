class Board
  attr_reader :cells

  def initialize
    @cells = cell_generator
  end

  def cell_generator
    y_axis      = ("A".."D").to_a
    x_axis      = ("1".."4").to_a
    coordinates = []
    cells       = {}

    y_axis.each do |letter|
      x_axis.each do |number|
        coordinates << "#{letter}#{number}"
      end
    end
    coordinates.map do |coordinate|
      cells[coordinate] = Cell.new(coordinate)
    end
    cells
  end

  def valid_coordinate?(cell)
    @cells.has_key?(cell)
  end

  def valid_placement?(ship, placements)
    ship.length == placements.length
    place_split = placements.map do |placement|
      placement.split("")
    end
    place_lets = place_split.map do |element|
      element[0]
    end
    place_nums = place_split.map do |element|
      element[1]
    end
    ords = place_lets.map do |letter|
      letter.ord
    end
    groups = []
    @cells.keys.each_cons(ship.length) do |group|
      groups << group
    end
    groups.any?(placements) || place_nums.all?(place_nums[0]) && consecutive_check = ords.each_cons(2).all? {|a, b| b == a + 1 }
  end
end

# Random thoughts: an OR statement that evaluates all the same .ord number on one side, and consecutive numbers after .split("A"||"B"||etc.) on the other
#Another idea: make an array of arrays of each row and column, and see if placement matches part of any item (possibly with each_cons). Block (any?) checks to see if coordinate match any of the arrays.
# i = [['a','b','c','d'],['e','f','g','h']]
# i.any? { |s| s.include?(['b','c'])}
