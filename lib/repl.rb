require 'pry'

module Repl

  def receive_input
    @input = gets.chomp.strip.downcase
    quit_if_q(@input)
    @input
  end

  def valid_initial_input?(input)
    input_is_instructions?(input) || input_is_play?(input)
  end

  def input_is_instructions?(input)
    input == "i" || input == "instructions"
  end

  def input_is_play?(input)
    input == "p" || input == "play"
  end

  def ship_placement_input(input)
    quit_if_q(input)
    input.upcase.split(" ").sort
  end

  def quit_if_q(input)
    if input == "q" || input == "quit"
      display_goodbye
      exit
    end
  end

  def enter_to_proceed
    display_enter_to_continue_prompt
    input = receive_input
    if input.nil?
    end
  end





end
