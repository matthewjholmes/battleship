require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @board = Board.new
  end

  it 'returns call classes' do
    expect = {
     "A1" => Cell.new,
     "A2" => Cell.new,
     "A3" => Cell.new,
     "A4" => Cell.new,
     "B1" => Cell.new,
     "B2" => Cell.new,
     "B3" => Cell.new,
     "B4" => Cell.new,
     "C1" => Cell.new,
     "C2" => Cell.new,
     "C3" => Cell.new,
     "C4" => Cell.new,
     "D1" => Cell.new,
     "D2" => Cell.new,
     "D3" => Cell.new,
     "D4" => Cell.new
    }
    expect(@board.cells.values).to be_a(Cell)
    expect(@board.cells).to be_a(Hash)
    expect(@board.cells).to eq(expect)
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
