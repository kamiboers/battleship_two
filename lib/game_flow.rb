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
    store_and_duplicate_boards_for_play
    begin_game_loop
  end

  def generate_user_and_computer_input
    @user_input = UserInput.new
    @computer_input = ComputerInput.new
  end

  def placement_of_user_and_computer_ships
    @computer_input.computer_places_all_ships
    @user_input.user_prompted_to_place_ships
  end

  def store_and_duplicate_boards_for_play
    store_boards_in_game_flow
    generate_user_view_board
    hide_ships_on_user_view_board
  end

  def begin_game_loop
    game_tracker = GameStats.new
    game_loop(game_tracker)
    end_of_game_sequence(game_tracker)
  end

  def game_loop(game_tracker)
    until @game_over == true do
    user_shot_sequence(game_tracker)
      break if @game_over == true
    computer_shot_sequence(game_tracker)
    end
  end

  def user_shot_sequence(game_tracker)
    user_shot
    game_tracker.user_records_a_shot
    game_over_query(@user_view)
  end

  def computer_shot_sequence(game_tracker)
    computer_shot
    game_tracker.computer_records_a_shot
    game_over_query(@user_own)
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

  def generate_user_view_board
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
      report_input_invalid
      validate_player_shot(receive_input)
    end
  end

  def record_player_shot(cell_name)
    shot_cell = @user_view.select_cell_by_name(cell_name)
    if cell_has_not_yet_been_shot(shot_cell)
      redirect_hit_or_miss(shot_cell, cell_name)
    else
      report_duplicate_shot
      validate_player_shot(receive_input)
    end

  end

  def cell_has_not_yet_been_shot(cell)
    cell.value == "."
  end

  def cell_is_occupied_by_a_ship(cell)
    cell.ship == true
  end

  def redirect_hit_or_miss(shot_cell, cell_name)
    if cell_is_occupied_by_a_ship(shot_cell)
      hit_sequence(shot_cell, cell_name)
    elsif !cell_is_occupied_by_a_ship(shot_cell)
      miss_sequence(shot_cell)
    end
  end

  def hit_sequence(shot_cell, cell_name)
    change_values_of_cell_to_hit_values(shot_cell, cell_name)
    determine_whether_game_lost
  end

  def miss_sequence(shot_cell)
    shot_cell.value = "M"
    display_user_shot_result(false)
  end


  def change_values_of_cell_to_hit_values(shot_cell, cell_name)
    shot_cell.value = "H"
    display_user_shot_result(true)
    @user_view.ships_hit(cell_name)
  end

  def determine_whether_game_lost
    if @user_view.lost_game?
      @game_over = true
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
    redirect_computer_hit_or_miss(shot_cell, cell_name)
  end

  def redirect_computer_hit_or_miss(shot_cell, cell_name)
    if cell_is_occupied_by_a_ship(shot_cell)
      computer_hit_sequence(shot_cell, cell_name)
      determine_whether_game_lost_by_user
    elsif !cell_is_occupied_by_a_ship(shot_cell)
      computer_miss_sequence(shot_cell, cell_name)
    end
  end

  def computer_hit_sequence(shot_cell, cell_name)
    shot_cell.value = "H"
    display_computer_shot_result_message(true)
    @user_own.ships_hit(cell_name)
  end

  def computer_miss_sequence(shot_cell, cell_name)
    shot_cell.value = "M"
    display_computer_shot_result_message(false)
  end

  def determine_whether_game_lost_by_user
    if @user_own.lost_game?
      @game_over = true
    end
  end

  def end_of_game_sequence(game_tracker)
    total_time = game_tracker.timer_stopped.to_i
    record_game_tracker_data(total_time, game_tracker)
  end

  def record_game_tracker_data(total_time, game_tracker)
    total_shots = game_tracker.user_shots if @winner == "YOU"
    total_shots = game_tracker.computer_shots if @winner == "THE EVIL COMPUTER"
    display_end_of_game_message(@winner, total_shots, total_time)
    play_again?
  end

  def play_again?
    prompt_to_play_again
    if input_is_play?(receive_input)
      reset_game
    else
      report_input_invalid
      play_again?
    end
  end

  def reset_game
    @game_over = false
    begin_game_flow
  end

end
