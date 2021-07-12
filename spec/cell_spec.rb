require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
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
end


#
# pry(main)> cruiser = Ship.new("Cruiser", 3)
# # => #<Ship:0x00007f84f0891238...>
#
# pry(main)> cell.place_ship(cruiser)
#
# pry(main)> cell.ship
# # => #<Ship:0x00007f84f0891238...>
#
# pry(main)> cell.empty?
# # => false
