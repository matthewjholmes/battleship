require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/turn'
require 'pry'

RSpec.describe Turn do
  before(:each) do
    @turn      = Turn.new
    @board     = Board.new
    @cruiser   = Ship.new("Cruiser", 3)
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

    it 'computer places ships' do
      #We feel like we need to differently but are unsure how to approach it.
      expect(@turn.placement_generator.count).to eq(5)
      expect(@board.duplicates?).to eq(false)
      # expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    xit 'returns player placement message' do
      expect(@turn.player_placement_message).to eq("I have laid out my ships on the grid. \nYou now need to lay out your two ships. \nThe Cruiser is three units long and the Submarine is two units long.")
    end

    it 'accepts user input' do
      @turn.user_placement_input

    end
  end
end
