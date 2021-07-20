class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship       = nil
    @fired_upon = false

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
    if !empty?
      @ship.hit
    end
  end


  def render(argument = ".")
    if !empty? && @ship.sunk? == true
      "X"
    elsif empty? && fired_upon?
      "M"
    elsif !empty? && fired_upon?
      "H"
    elsif argument == true && !empty? #had to move this down since the ship was showing above a shot. Was above "m"
      "S"
    else
      "."
    end
  end
end
