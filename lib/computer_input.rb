require 'pry'
require_relative 'board'
require_relative 'text_interface'

class ComputerInput
  include TextInterface

  attr_reader :computer_board, :ships, :shot_array

  def initialize
    @computer_board = Board.new(opponent_id="You")
    @computer_board.ships << @tug_boat = Ship.new(name=first_computer_ship_name)
    @computer_board.ships << @submarine = Ship.new(name=second_computer_ship_name, length=3, filler="S")
    @shot_array = @computer_board.possible_positions.dup.shuffle
  end

  def computer_chooses_a_random_cell
    @computer_board.grid.flatten.sample.name
  end

  def computer_places_all_ships
    @computer_board.ships.each do |ship|
      computer_chooses_random_range_for_(ship)
    end
  end

  def computer_chooses_random_range_for_(ship)
    random_placement = computer_chooses_a_random_cell
    axis = (0..1).to_a.shuffle.pop
    range = [random_placement]
    increment_upwards_on_board(ship, random_placement, axis, range)
  end

  def increment_upwards_on_board(ship, placement, axis, range)
    until !ship.cells.empty?
    until range.count == ship.length
      next_cell = placement.gsub(placement[axis], placement[axis].next)
      range << next_cell
      increment_upwards_on_board(ship, next_cell, axis, range)
    end

    break if !ship.cells.empty?
    if values_present_on_board?(range) && all_values_unoccupied?(range)
      ship.cells << range
      ship.cells.flatten!
      place_all_on_board(range, ship.filler)
    else
      computer_chooses_random_range_for_(ship)
    end
  end

  end

  def values_present_on_board?(values_array)
    (values_array-@computer_board.possible_positions).empty?
  end


  def all_values_unoccupied?(ship_array)
    viability_of_spaces = ship_array.map do |cell_name|
      cell = @computer_board.select_cell_by_name(cell_name)
      cell.ship == false
    end
    !viability_of_spaces.include?(false)
  end

  def place_all_on_board(ship_array, ship_filler)
    ship_array.each do |cell_name|
      @computer_board.place_ship_on_cell(cell_name, ship_filler)
    end
  end

end
