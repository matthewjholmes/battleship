require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  it 'returns call classes' do
    expect = {
     "A1" => Cell.new(:key),
     "A2" => Cell.new(:key),
     "A3" => Cell.new(:key),
     "A4" => Cell.new(:key),
     "B1" => Cell.new(:key),
     "B2" => Cell.new(:key),
     "B3" => Cell.new(:key),
     "B4" => Cell.new(:key),
     "C1" => Cell.new(:key),
     "C2" => Cell.new(:key),
     "C3" => Cell.new(:key),
     "C4" => Cell.new(:key),
     "D1" => Cell.new(:key),
     "D2" => Cell.new(:key),
     "D3" => Cell.new(:key),
     "D4" => Cell.new(:key)
    }
    expect(expect.values.first).to be_a(Cell)
    expect(expect).to be_a(Hash)
    expect(@board.cells.count).to eq(16)
  end

  xit 'returns if corrdinates are on board' do
    expect(@board.valid_coordinate?("A1")).to eq(true)
    expect(@board.valid_coordinate?("D4")).to eq(true)
    expect(@board.valid_coordinate?("A5")).to eq(false)
    expect(@board.valid_coordinate?("E1")).to eq(false)
    expect(@board.valid_coordinate?("A22")).to eq(false)
  end

  xit 'returns valid if matching length of ship' do
    expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(false)
    expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to eq(false)
  end

  xit 'returns valid if corrdinates are consecutive' do
    expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
    expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
    expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq(false)
    expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq(false)
  end

  xit 'returns valid if not diagonal' do
    expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq(false)
    expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq(false)
  end

  xit 'returns valid placements' do
    expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to eq(true)
    expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq(true)
  end
end
