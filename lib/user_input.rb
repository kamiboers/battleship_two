require 'pry'
require_relative 'board'
require_relative 'text_interface'
require_relative 'repl'
require_relative 'placement_verifier'


class UserInput
  include TextInterface
  include Repl
  include PlacementVerifier

  attr_reader :user_board, :ships

  def initialize
    @user_board = Board.new(opponent_id="THE EVIL COMPUTER")
    @user_board.ships << @tug_boat = Ship.new(name=first_user_ship_name)
    @user_board.ships << @submarine = Ship.new(name=second_user_ship_name, length=3, filler="S")
  end

  def user_prompted_to_place_ships
    first_ship_placement_sequence
    second_ship_placement_sequence
    @user_board.display_board
  end

  def first_ship_placement_sequence
    display_prompt_to_place_first_ship
    vet_ship_placement(ship_placement_input(receive_input.upcase), @user_board.ships[0])
  end

  def second_ship_placement_sequence
    @user_board.display_board
    display_prompt_to_place_next_ship
    vet_ship_placement(ship_placement_input(receive_input.upcase), @user_board.ships[1])
  end

  def accept_and_place_ship(placement_array, ship)
      ship.cells << placement_array
      ship.cells.flatten!
      place_all_on_board(placement_array, ship.filler)
  end

  def place_all_on_board(ship_array, ship_filler)
    ship_array.each do |cell_name|
      @user_board.place_ship_on_cell(cell_name, ship_filler)
    end
  end

  def convert_array_to_appropriate_length(array, ship_length)
    if ship_length == 2
      array
    elsif ship_length == 3
      middle_cell = find_middle_cell_in_appropriate_direction(array)
        array << middle_cell
        array = array.sort
      end
  end

  def find_middle_cell_in_appropriate_direction(array)
    if vertical_ship_orientation(array)
      ( array.first[0].next + array.first[1] )
    elsif horizontal_ship_orientation(array)
      ( array.first[0] + array.first[1].next )
    end
  end

end
