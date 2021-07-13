require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    @cell_2 = Cell.new("C3")
    @cruiser = Ship.new("Cruiser", 3)
  end

    it 'exists and has attributes' do
      expect(@cell).to be_instance_of(Cell)
      expect(@cell.coordinate).to eq("B4")
    end

    it 'returns nil for ship method' do
      expect(@cell.ship).to eq(nil)
    end

    it 'returns true for empty? method' do
      expect(@cell.empty?).to eq(true)
    end

    it 'assigns a ship object to the cell & cell is no longer empty' do
      @cell.place_ship(@cruiser)

      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to eq(false)
    end

    it 'can place a ship' do
      @cell.place_ship(@cruiser)

      expect(@cell.fired_upon?).to eq(false)
    end

    it 'can fire upon a cell' do
      @cell.place_ship(@cruiser)

      expect(@cell.fired_upon?).to eq(false)

      @cell.fire_upon

      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to eq(true)
    end

    it 'has a render method, registers miss, can take argument' do
      expect(@cell.render).to eq(".")

      @cell.fire_upon

      expect(@cell.render).to eq("M")

      @cell_2.place_ship(@cruiser)

      expect(@cell_2.render).to eq(".")

      expect(@cell_2.render(true)).to eq("S")

      @cell_2.fire_upon

      expect(@cell_2.render).to eq("H")
    end

    it 'can sink a ship' do
      @cell_2.place_ship(@cruiser)

      @cell_2.fire_upon

      expect(@cruiser.sunk?).to eq(false)

      @cruiser.hit
      @cruiser.hit

      expect(@cruiser.sunk?).to eq(true)
      expect(@cell_2.render).to eq("X")
    end
end
