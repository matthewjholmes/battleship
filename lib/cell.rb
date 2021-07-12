class Cell

  attr_reader :coordinate

  def initialize(coordinate)
    @coordinate = coordinate
    # @ship = nil
    # @empty = true
  end

  def ship
    nil
  end

  def empty?
    true
  end
end
