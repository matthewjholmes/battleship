require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @cell_1 = board.cells["A1"]# => #<Cell:0x00007fcb0e1f66a8...>
    @cell_2 = board.cells["A2"]# => #<Cell:0x00007fcb0e1f6630...>
    @cell_3 = board.cells["A3"]# => #<Cell:0x00007fcb0e1f65b8...>
  end

  it 'returns call classes' do
    expect(@board.cells["A1"]).to be_a(Cell)
    expect(@board.cells).to be_a(Hash)
  end

  it 'returns if coordinates are on board' do
    expect(@board.valid_coordinate?("A1")).to eq(true)
    expect(@board.valid_coordinate?("D4")).to eq(true)
    expect(@board.valid_coordinate?("A5")).to eq(false)
    expect(@board.valid_coordinate?("E1")).to eq(false)
    expect(@board.valid_coordinate?("A22")).to eq(false)
  end

  it 'returns valid if matching length of ship' do
    expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(false)
    expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to eq(false)
  end

  it 'returns valid if coordinates are consecutive' do
    expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
    expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
    expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq(false)
    expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq(false)
  end

  it 'returns valid if not diagonal' do
    expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq(false)
    expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq(false)
  end

  it 'returns valid placements' do
    expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to eq(true)
    expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq(true)
    expect(@board.valid_placement?(@cruiser, ["A1", "C1", "D1"])).to eq(false)
    expect(@board.valid_placement?(@submarine, ["A2", "B2"])).to eq(true)
  end

  it 'places ships' do
    @board.place(@cruiser, ["A1", "A2", "A3"])

    expect(@cell_1.ship).to eq(@cruiser)
    expect(@cell_2.ship).to eq(@cruiser)
    expect(@cell_3.ship).to eq(@cruiser)

    expect(@cell_3.ship == @cell_2.ship).to eq(true)
  end

  it 'ships do not overlap' do
    @board.place(@cruiser, ["A1", "A2", "A3"])
    expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to eq(false)
  end
end
