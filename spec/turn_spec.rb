require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/turn'
require 'pry'

RSpec.describe Turn do
  before(:each) do
    @turn = Turn.new
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  it 'exists and has attributes' do
    expect(@turn).to be_instance_of(Turn)
    expect(@turn.ships).to eq([])
  end

  describe 'add ship objects' do
    before(:each) do
      @turn.add_ship(@cruiser)
      @turn.add_ship(@submarine)
    end

    it 'adds ships' do
      expect(@turn.ships).to eq([@cruiser, @submarine])
    end

    xit '#welcome' do
      expect(@turn.welcome).to eq("Welcome to BATTLESHIP Enter p to play. Enter q to quit.")
    end

    xit '#game_menu' do
      expect(@turn.quit).to eq("Thanks for playing, sucka")
      expect(@turn.play).to eq("exit")
      expect(@turn.game_menu).to eq("exit")
    end

    it 'places ships' do
      expect(@turn.placement_generator).to eq(3)
      # expect(@turn.placement_cruiser).to eq(3)
      # expect(@turn.placement_submarine).to eq(2)
    end
  end
end
