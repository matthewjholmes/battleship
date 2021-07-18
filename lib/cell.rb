class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship       = nil
    @fired_upon = false
    @render     = "."
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if empty?
      @render = "M"
    else
      @ship.hit
      @render = "H"
    end
  end

  def render(argument = false)
    # if @ship.sunk? == true
    #   "X"
    # elsif @cell.place_ship == true && fired_upon? == true
    #   "H"
    if !empty? && @ship.sunk? == true
      @render = "X"
    elsif argument == true && !empty?
      "S"
    else
      @render
    end
  end
end
