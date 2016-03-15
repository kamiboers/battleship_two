require 'pry'
require_relative 'text_interface'
require_relative 'repl'
require_relative 'game_flow'


class Battleship
  include TextInterface
  include Repl
  include GameFlow

  def begin_game_prompt
    game_introduction
    prompt_to_play
    user_chosen_direction(receive_input)
  end

  def user_chosen_direction(input)
    if input_is_play?(input)
      begin_game_flow
    else
      redirect_to_instructions_or_invalid_response(input)
      begin_game_prompt
    end
  end

  def redirect_to_instructions_or_invalid_response(input)
    if input_is_instructions?(input)
      show_player_instructions
    else
      report_input_invalid
    end
  end

end


if __FILE__ == $0
  b = Battleship.new
  b.begin_game_prompt
end
