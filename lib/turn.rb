require './lib/board'

class Turn
  attr_reader :ships

  def initialize
    @ships = []
    @board = Board.new
  end

  def add_ship(ship)
    @ships << ship
  end

  def welcome
    print "Welcome to BATTLESHIP \nEnter p to play. Enter q to quit. \n>"
    game_menu(gets.chomp.downcase)
  end

  def quit
    puts "Thanks for playing, sucka"
    exit
  end

  def game_menu(input)
    if input == ("p" || "play")
    elsif input == ("q" || "quit")
      quit
    else
      puts "Write better, fool!"
      sleep 2
      welcome
    end
  end

  def placement_generator
    @ships.each do |ship|
      p = false
      e = []
      while p == false
        e = @board.cells.keys.sample(ship.length)
        p = @board.valid_placement?(ship, e)
      end
      @board.place(ship, e)
    end
    @board.taken_cells
  end

  def player_placement_message
    puts "I have laid out my ships on the grid. \nYou now need to lay out your two ships. \nThe Cruiser is three units long and the Submarine is two units long."
  end

  def user_placement_input
    print "Enter Cruiser Coordinates > "

    cruiser_coordinates   = "a1 a2 A3"
    submarine_coordinates = "b2 C2"
    cruiser_coordinates.upcase.split(' ')

    until @board.valid_placement?(@ships[0], cruiser_coordinates)
      require "pry"; binding.pry
      puts @board.render(true)
      puts "Invalid coordinates. Try again!"
    end
    require "pry"; binding.pry
      puts "Enter Submarine Coordinates > "
      submarine_coordinates.upcase.split(' ')
      @board.valid_placement?(@submarine, submarine_coordinates)

    # user_placement
  end
end
# turn = Turn.new
# turn.welcome
