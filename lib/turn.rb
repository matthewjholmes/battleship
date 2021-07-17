require './lib/board'

class Turn

  attr_reader :ships

  def initialize
    @ships = []
  end

  def add_ship(ship)
    @ships << ship
  end

  def welcome
    print "Welcome to BATTLESHIP \nEnter p to play. Enter q to quit. \n>"
    game_menu(gets.chomp)
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
    p = false
    e = []
    @ships.each do |ship|
      while p == false
        e = @board.cells.keys.sample(ship.length)
        p = @board.valid_placement?(@cruiser, e)
        p
      end
      @board.place(ship, e)

    end

  end
end
# turn = Turn.new
# turn.welcome
