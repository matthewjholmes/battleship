require_relative 'cell'

class Board
  attr_reader :cells

  def initialize
    @cells       = cell_generator
  end

  def cell_generator
    y_axis      = ("A".."D").to_a
    x_axis      = ("1".."4").to_a
    coordinates = []
    cells       = {}

    y_axis.each do |letter|
      x_axis.each do |number|
      coordinate = "#{letter}#{number}"
      cells[coordinate] = Cell.new(coordinate)
      end
    end
    cells
  end

  def valid_coordinate?(cell)
    @cells.has_key?(cell) && !@cells[cell].fired_upon? && !@cells[cell].ship
  end

  def row_or_column_validation(placements)
    place_split = placements.map do |placement|
      placement.split("")
    end
    place_lets = place_split.map do |letter|
      letter[0]
    end
    place_nums = place_split.map do |number|
      number[1].to_i
    end
    ords = place_lets.map do |letter|
      letter.ord
    end
    all_same_letter = ords.all?(ords[0])
    all_same_number = place_nums.all?(place_nums[0])
    numbers_increment_by_one = place_nums.each_cons(2).all? {|a, b| b == a + 1 }
    letters_increment_by_one = ords.each_cons(2).all? {|a, b| b == a + 1 }
    (all_same_letter && numbers_increment_by_one) || (all_same_number && letters_increment_by_one)
  end

  def valid_placement?(ship, placements)
    return false unless ship.length == placements.count
    placements.find do |cell|
      if valid_coordinate?(cell) == false
        return false
      end
    end
    row_or_column_validation(placements)
  end

  def place(ship, placements)
    placements.each do |cell|
      @cells[cell].place_ship(ship)
    end
  end

  def render(render = false)
    y_axis = ("A".."D").to_a
    sentence = @cells.map do |cell|
      " " + cell[1].render(render)
    end
    lines = sentence.join.scan(/.{8}/)
    lines.unshift("  1 2 3 4")
    board = lines.each do |line|
       line.concat(" \n")
    end
    board.zip(y_axis).join
  end
end
