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
end
