require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
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
end
