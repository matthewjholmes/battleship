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
    @cells[cell].coordinate == cell
  end

  def valid_placement?(ship, placements)
    ship.length == placements.length
    #Random thoughts: an OR statement that evaluates all the same .ord number on one side, and consecutive numbers after .split("A"||"B"||etc.) on the other
    
  end
end
