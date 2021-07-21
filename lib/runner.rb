require_relative 'board'
require_relative 'ship'
require_relative 'messages'

    @messages       = Messages.new
    @comp_board     = Board.new
    @user_board     = Board.new
    @comp_cruiser   = Ship.new("Cruiser", 3)
    @cruiser        = Ship.new("Cruiser", 3)
    @comp_submarine = Ship.new("Submarine", 2)
    @submarine      = Ship.new("Submarine", 2)
    @comp_ships     = [@comp_cruiser, @comp_submarine]
    @user_ships     = [@cruiser, @submarine]

  def game_beginning
    puts @messages.image
    print @messages.welcome_message
    game_menu(gets.strip.downcase)
  end

  def quit
    puts @messages.quit_message
    exit
  end

  def game_menu(input)
    if input == ("p" || "play")
      placement_generator
      player_placement_message
    elsif input == ("q" || "quit")
      quit
    else
      puts @messages.write_better_message
      sleep 2
      game_beginning
    end
  end

  def placement_generator
    @comp_ships.each do |ship|
      valid  = false
      coords = []
      while valid == false
        coords = @comp_board.cells.keys.sample(ship.length)
        valid  = @comp_board.valid_placement?(ship, coords)
      end
      @comp_board.place(ship, coords)
    end
  end

  def player_placement_message
    puts @messages.player_placement_message
    user_placement
  end

  def user_placement
    @user_ships.each do |ship|
      puts @user_board.render(true)
      print "Enter #{ship.length} coordinates to place your #{ship.name} > "
      input = gets.chomp.upcase.split(' ')
      until @user_board.valid_placement?(ship, input)
        print "Invalid, enter #{ship.length} coordinates > "
        input = gets.chomp.upcase.split(' ')
      end
      @user_board.place(ship, input)
    end
    puts "\n\n********** Game on! ***********\n\n"
    take_turn
  end

  def user_fire
    fire_coordinate = gets.strip.upcase
    if !@comp_board.cells.has_key?(fire_coordinate)
      puts @messages.invalid_coordinate_message
      take_turn
    elsif @comp_board.cells[fire_coordinate].fired_upon?
      puts @messages.repeat_coord_message
      take_turn
    else
      fire_coordinate
    end
    fire_coordinate
  end

  def take_turn
    puts "\n=============COMPUTER BOARD=============\n" + @comp_board.render
    puts "==============PLAYER BOARD==============\n" + @user_board.render(true)
    print "Enter the coordinate for your shot! \n>"
    fire_coordinate = user_fire
    @comp_board.cells[fire_coordinate].fire_upon
    comp_shot = comp_fire
    @user_board.cells[comp_shot].fire_upon
    sleep 0.5
    puts "Your shot on #{fire_coordinate} was a #{@messages.cell_feedback(@comp_board, fire_coordinate)}."
    if @messages.cell_feedback(@comp_board, fire_coordinate) == "sink"
      sleep 0.25
      puts "You sunk my #{@comp_board.cells[fire_coordinate].ship.name}."
      sleep 0.25
    end
    sleep 0.5
    puts "My shot on #{comp_shot} was a #{@messages.cell_feedback(@user_board, comp_shot)}.\n"
    if @messages.cell_feedback(@user_board, comp_shot) == "sink"
      puts "I sunk your #{@user_board.cells[comp_shot].ship.name}"
    end
    sleep 0.5
    game_loop
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
      game_beginning
    else
      take_turn
    end
  end

  def end_game
    if @comp_ships.all?(&:sunk?)
      puts "You win"
      game_beginning
    else
      puts "I win, you suck"
      game_beginning
    end
  end

game_beginning
