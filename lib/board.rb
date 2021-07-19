require_relative 'cell'

class Board
  attr_reader :cells,
              :taken_cells

  def initialize
    @cells       = cell_generator
    @taken_cells = []
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
    @cells.has_key?(cell) && !@taken_cells.include?(cell)
  end

  def valid_placement?(ship, placements)
    return false unless ship.length == placements.count
    placements.find do |cell|
      return false unless valid_coordinate?(cell)
    end
    place_split = placements.map do |placement|
      placement.split("")
    end
    place_lets = place_split.map do |element|
      element[0]
    end
    place_nums = place_split.map do |element|
      element[1].to_i
    end
    ords = place_lets.map do |letter|
      letter.ord
    end
    (ords.all?(ords[0]) && place_nums.each_cons(2).all? {|a, b| b == a + 1 }) || (place_nums.all?(place_nums[0]) && ords.each_cons(2).all? {|a, b| b == a + 1 })
  end

  def place(ship, placements)
    placements.each do |cell|
      @cells[cell].place_ship(ship)
      @taken_cells << cell
    end
  end

  def render(render = false)
    y_axis = ("A".."D").to_a
    sentence = @cells.map do |cell|
      " " + cell[1].render(render)
    end
    lines = sentence.join.scan(/.{8}/)
    lines.unshift("\n  1 2 3 4")
    board = lines.each do |line|
       line.concat(" \n")
    end
    board.zip(y_axis).join
  end
end
