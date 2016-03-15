require 'pry'
require_relative 'computer_input'
require_relative 'user_input'
require_relative 'repl'
require_relative 'game_stats'


module GameFlow

  def initialize
    @game_over = false
  end

  def begin_game_flow
    generate_user_and_computer_input
    placement_of_user_and_computer_ships
  end

  def generate_user_and_computer_input
    @user_input = UserInput.new
    @computer_input = ComputerInput.new
  end

  def placement_of_user_and_computer_ships
    @computer_input.computer_places_all_ships
    @user_input.user_prompted_to_place_ships

    store_boards_in_game_flow
    generate_user_and_computer_view_boards
    hide_ships_on_user_view_board
    game_tracker = GameStats.new
    until @game_over == true do
      user_shot
      game_tracker.user_records_a_shot
      game_over_query(@user_view)
      break if @game_over == true
      computer_shot
      game_tracker.computer_records_a_shot
      game_over_query(@user_own)
    end
    end_of_game(game_tracker)
    play_again?
  end

  def game_over_query(board)
    if board.lost_game?
      @game_over = true
      @winner = board.opponent_id
    end
  end

  def store_boards_in_game_flow
    @user_own = @user_input.user_board
    @computer_own = @computer_input.computer_board
  end

  def generate_user_and_computer_view_boards
    @user_view = @computer_own.dup
  end

  def hide_ships_on_user_view_board
    @user_view.grid = @user_view.grid.map do |cell|
      cell.value = "."
      cell
    end
  end

  def user_shot
    user_turn_title
    @user_view.display_board
    get_user_shot
    validate_player_shot(receive_input)
    enter_to_proceed
  end

  def validate_player_shot(input)
    if input.length == 2 && @user_view.possible_positions.include?(input.upcase)
      record_player_shot(input.upcase)
    else
      puts "Invalid input, try again:"
      validate_player_shot(receive_input)
    end
  end

  def record_player_shot(cell_name)
    shot_cell = @user_view.select_cell_by_name(cell_name)
    if shot_cell.value == "."
      if shot_cell.ship == true
        shot_cell.value = "H"
        display_user_shot_result(true)
        @user_view.ships_hit(cell_name)
        if @user_view.lost_game?
          @game_over = true
        end
      elsif shot_cell.ship == false
        shot_cell.value = "M"
        display_user_shot_result(false)
      end
    else
      puts "You've already shot at this position. Shoot again:"
      get_user_shot
    end

  end

  def display_user_shot_result(outcome)
    display_user_shot_result_message(outcome)
    @user_view.display_board
  end

  def computer_shot
    computer_turn_title
    shot = @computer_input.shot_array.pop
    record_computer_shot(shot)
    enter_to_proceed
  end

  def record_computer_shot(cell_name)
    shot_cell = @user_own.select_cell_by_name(cell_name)
    if shot_cell.ship == true
      shot_cell.value = "H"
      display_computer_shot_result_message(true)
      @user_own.ships_hit(cell_name)
      if @user_own.lost_game?
        @game_over = true
      end
    elsif shot_cell.ship == false
      shot_cell.value = "M"
      display_computer_shot_result_message(false)
    end
  end

  def end_of_game(game_tracker)

    total_time = game_tracker.timer_stopped.to_i

    if @winner == "You"
      total_shots = game_tracker.user_shots
    elsif @winner == "THE EVIL COMPUTER"
      total_shots = game_tracker.computer_shots
    end

    display_end_of_game_message(@winner, total_shots, total_time)
  end

  def play_again?
    prompt_to_play_again
    if input_is_play?(receive_input)
      begin_game_flow
    else
      report_input_invalid
      play_again?
    end
  end

end
