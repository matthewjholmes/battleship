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

  # def placement_generator
  #   test = @ships.each do |ship|
  #     p = false
  #     e = []
  #     loop_test = while p == false
  #       e = @board.cells.keys.sample(ship.length)
  #       p = @board.valid_placement?(ship, e)
  #       p
  #     end
  #     placement_test = @board.place(ship, e)
  #     require "pry"; binding.pry
  #   end
  # end

  def placement_cruiser
      p = false
      e = []
      loop_test = while p == false
        e = @board.cells.keys.sample(3)
        p = @board.valid_placement?(@cruiser, e)
        p
      end
      placement_test = @board.place(@cruiser, e)
      require "pry"; binding.pry
  end

  def placement_submarine
      p = false
      e = []
      loop_test = while p == false
        e = @board.cells.keys.sample(3)
        p = @board.valid_placement?(@submarine, e)
        p
      end
      placement_test = @board.place(@submarine, e)
      require "pry"; binding.pry
  end
end
# turn = Turn.new
# turn.welcome
