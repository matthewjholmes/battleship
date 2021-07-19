require_relative 'board'
require_relative 'ship'

    @comp_board     = Board.new
    @user_board     = Board.new
    @comp_cruiser   = Ship.new("Cruiser", 3)
    @cruiser        = Ship.new("Cruiser", 3)
    @comp_submarine = Ship.new("Submarine", 2)
    @submarine      = Ship.new("Submarine", 2)
    @comp_ships     = [@comp_cruiser, @comp_submarine]
    @user_ships     = [@cruiser, @submarine]

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
      placement_generator
      player_placement_message
    elsif input == ("q" || "quit")
      quit
    else
      puts "Write better, fool!"
      sleep 2
      welcome
    end
  end

  def placement_generator
    @comp_ships.each do |ship|
      p = false
      e = []
      while p == false
        e = @comp_board.cells.keys.sample(ship.length)
        p = @comp_board.valid_placement?(ship, e)
      end
      @comp_board.place(ship, e)
    end
  end

  def player_placement_message
    puts "I have laid out my ships on the grid. \nYou now need to lay out your two ships. \nThe Cruiser is three units long and the Submarine is two units long."
    user_placement_input
  end

  def user_placement_input
    puts @user_board.render(true)
    print "Enter Cruiser Coordinates > "
    cruiser_coordinates = gets.chomp.upcase.split(' ')
    until @user_board.valid_placement?(@user_ships[0], cruiser_coordinates)
      puts @user_board.render(true)
      puts "Invalid coordinates. Try again!"
      cruiser_coordinates = gets.chomp.upcase.split(' ')
    end
    puts @user_board.render(true)

    print "Enter Submarine Coordinates >"

    raw_submarine_coordinates = gets.chomp
    submarine_coordinates = raw_submarine_coordinates.upcase.split(' ')
    until @user_board.valid_placement?(@user_ships[1], submarine_coordinates)
      puts @user_board.render(true)
      puts "Invalid coordinates. Try again!"

      puts "Enter Submarine Coordinates > "
      raw_submarine_coordinates = gets.chomp
      submarine_coordinates = raw_submarine_coordinates.upcase.split(' ')
      puts "Invalid coordinates. Try again!"
    end
    puts "Game on"
    require "pry"; binding.pry
    # user_placement
  end
  puts welcome
