require 'pry'

module TextInterface

  def game_introduction
    puts "\n\n\nWelcome to BATTLESHIP"
  end

  def prompt_to_play
    puts "\n Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
  end

  def show_player_instructions
    puts "\n\nBATTLESHIP's rules are really kind of tedious to copy and paste, so I'm filling this space with relatively unhelpful content.\nYou've totes played BATTLESHIP before. Just try to hit the ships, and you'll forget all about docking points for laziness.\n"
  end

  def report_input_invalid
    puts "\n\nEntry invalid. Please try again:\n"
  end

  def display_prompt_to_place_first_ship
    puts "\n\tI have laid out my ships on the grid.\n\tYou now need to lay out your two ships.\n\tThe first is two units long and\n\tthe second is three units long.\n\tThe grid has A1 at the top left and D4 at the bottom right.\n\n\tEnter the beginning and ending squares for the two-unit ship:\n\n"
  end

  def display_prompt_to_place_next_ship
    puts "Please enter the beginning and ending squares for the three-unit ship:"
  end

  def get_user_shot
    puts "It's your turn to shoot! Choose a square:"
  end

  def display_user_shot_result_message(outcome)
    if outcome == true
      puts "\n\nYou got a hit!\n"
    elsif outcome == false
      puts "\n\nToo bad, you missed!\n"
    end
  end

  def display_computer_shot_result_message(outcome)
    if outcome == true
      puts "\n\nThe Enemy has hit your ship!\n"
      @user_own.display_board
    elsif outcome == false
      puts "\n\nThe Enemy missed!\n"
      @user_own.display_board
    end
  end


def display_sunken_ship_message(sunken_ship)
  puts "\n#{sunken_ship.name} with a length of #{sunken_ship.length} was sunk!\n" if !ships_sunk?.nil?
end

  def end_game_message(winner, shots, time)
    puts "You/Computer WIN!!!"
    puts "It took x shots over x amt of time."
    prompt_to_play_again
  end

  def prompt_to_play_again
    puts "Would you like to (p)lay again or (q)uit?"
  end

  def display_goodbye
    puts "\nGoodbye.\n\n"
  end

  def display_enter_to_continue_prompt
    puts "Press Enter to proceed."
  end

  def user_turn_title
    puts "\n\nYour Turn:\n"
  end

  def computer_turn_title
    puts "\n\nThe Enemy has opened fire!\n"
  end

  def display_not_two_coordinates_error
    puts "\nExactly two coordinates required. Try again:"
  end

  def display_wrong_ship_length_coordinate_error
    puts "\nWrong number of cells for your ship's length. Try again:"
  end

  def display_wrong_coordinate_length_error
    puts "\nAll placements should be two characters separated by a space. Try again:\n"
  end

  def display_bad_cell_name_error
    puts "\nThose values are not present in the board. Try again:\n"
  end

  def display_nonconsecutive_coordinate_error
    puts "\nThose are not consecutive in the vertical or horizontal direction. Try again:\n"
  end

  def display_occupied_cell_error
    puts "\nAt least one of those cells is already occupied. Try again:\n"
  end

  def first_user_ship_name
    "Your Tugboat"
  end

  def second_user_ship_name
    "Your Submarine"
  end

  def first_computer_ship_name
    "ENEMY TUGBOAT"
  end

  def second_computer_ship_name
    "ENEMY SUBMARINE"
  end

  def display_end_of_game_message(winner, shots, time)
    puts "The winner is #{winner}!!!!\n#{winner} took it down with #{shots} shots in #{time/60} minutes and #{time%60} seconds!"
  end


end
