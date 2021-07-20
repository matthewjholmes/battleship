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
        p = @comp_board.valid_placement?(ship, e) && e.all? do |cell|
          @comp_board.cells[cell].empty?
        end
      end
      @comp_board.place(ship, e)
    end
  end

  def player_placement_message
    puts "I have laid out my ships on the grid. \nYou now need to lay out your two ships. \nThe Cruiser is three units long and the Submarine is two units long."
    puts @comp_board.render(true)
    user_placement_input
  end

  def user_placement_input
    puts @user_board.render(true)
    print "Enter Cruiser Coordinates > "
    cruiser_coordinates = gets.chomp.upcase.split(' ')
    until @user_board.valid_placement?(@user_ships[0], cruiser_coordinates) && cruiser_coordinates.all? { |cell| @user_board.cells[cell].empty? }
      puts @user_board.render(true)
      puts "Invalid coordinates. Try again!"
      cruiser_coordinates = gets.chomp.upcase.split(' ')
    end
    @user_board.place(@cruiser, cruiser_coordinates)
    puts @user_board.render(true)
    print "Enter Submarine Coordinates >"

    submarine_coordinates = gets.chomp.upcase.split(' ')
    until @user_board.valid_placement?(@user_ships[1], submarine_coordinates) && submarine_coordinates.all? { |cell| @user_board.cells[cell].empty? }
      puts @user_board.render(true)
      puts "Invalid coordinates. Try again!"
      puts "Enter Submarine Coordinates > "
      submarine_coordinates = gets.chomp.upcase.split(' ')
    end
    @user_board.place(@submarine, submarine_coordinates)
    puts @user_board.render(true)
    puts "Game on"
    take_turn
  end

  def user_fire
    fire_coordinate = gets.chomp.upcase
    if !@comp_board.cells.has_key?(fire_coordinate)
      puts "Invalid coordinate. Try again!"
      take_turn
    elsif @comp_board.cells[fire_coordinate].fired_upon?
      puts "You're repeating yourself. Got memory loss?"
      take_turn
    else
      fire_coordinate
    end
    fire_coordinate
  end

  def take_turn
    puts "\n=============COMPUTER BOARD============="
    puts @comp_board.render
    puts "==============PLAYER BOARD=============="
    puts @user_board.render(true)
    print "Enter the coordinate for your shot! \n>"
    fire_coordinate = user_fire
    @comp_board.cells[fire_coordinate].fire_upon
    comp_shot = comp_fire
    @user_board.cells[comp_shot].fire_upon
    sleep 1
    puts "Your shot on #{fire_coordinate} was a #{cell_feedback(@comp_board, fire_coordinate)}."
    if cell_feedback(@comp_board, fire_coordinate) == "sink"
      puts "You sunk my #{@comp_board.cells[fire_coordinate].ship.name}."

    end
    sleep 1
    puts "My shot on #{comp_shot} was a #{cell_feedback(@user_board, comp_shot)}.\n"
    if cell_feedback(@user_board, comp_shot) == "sink"
      puts "I sunk your #{@user_voard.cells[comp_shot].ship.name}"
    end
    sleep 1
    game_loop
  end

  def cell_feedback(user, cell)
    if user.cells[cell].render ==  "X"
      "sink"
    elsif user.cells[cell].render ==  "H"
      "hit"
    elsif user.cells[cell].render ==  "M"
      "miss"
    else
      "you fucked up your code"
    end
  end

  def comp_fire
    free_cells = []
    @user_board.cells.map do |key, value|
      value.fired_upon? == false
      free_cells << key
    end
    free_cells.shuffle.first
  end

  def game_loop
    if @comp_ships.all?(&:sunk?) || @user_ships.all?(&:sunk?)
      end_game
      welcome
    else
      take_turn
    end
  end

  def end_game
    if @comp_ships.all?(&:sunk?)
      puts "You win"
    else
      puts "I win, you suck"
    end
  end

  puts welcome
