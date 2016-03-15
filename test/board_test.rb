require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/board'
require 'pry'

class BoardTest < Minitest::Test

  def test_select_cell_by_name_selects_named_cell
    board = Board.new(id="id", board_size=8)
    cell = board.select_cell_by_name("C3")
    cell1 = board.select_cell_by_name("F7")

    assert_equal "C3", cell.name
    assert_equal "F7", cell1.name
  end

  def test_board_scalably_populates_and_names_all_cells
    board = Board.new
    board1 = Board.new(id="id", board_size=8)

    assert_equal "A1", board.grid.flatten.first.name
    assert_equal "A1", board1.grid.flatten.first.name
    assert_equal "D4", board.grid.flatten.last.name
    assert_equal "H8", board1.grid.flatten.last.name
  end

  def test_assign_row_headings_gives_appropriate_number_of_headings
    board = Board.new
    board1 = Board.new(id="id", board_size=8)

    assert_equal ("A".."Z").first(4), board.assign_row_headings
    assert_equal ("A".."Z").first(8), board1.assign_row_headings
  end

  def test_board_instantiates_with_no_hits_or_ships
    board = Board.new

    assert_equal 0, board.hits
    assert board.ships.empty?
  end

  def test_board_holds_appropriate_array_of_cell_names_and_headings
    board = Board.new(id="id", board_size=8)
    board.store_possible_positions

    assert_equal "A3", board.possible_positions[2]
    assert_equal 64, board.possible_positions.length
    assert_equal "H", board.row_headings.last
    assert_equal 8, board.row_headings.length
  end

  def test_board_can_locate_cells_by_name
    board = Board.new(id="id", board_size=8)
    target_cell = board.select_cell_by_name("C4")
    assert_equal "C4", target_cell.name
    assert target_cell.instance_of? Cell
  end

  def test_board_returns_nil_for_nonexistent_cells
    board = Board.new(id="id", board_size=8)
    target_cell = board.select_cell_by_name("Z4")

    refute target_cell
  end

  def test_board_can_place_ship_on_cell_and_change_key_values
    board = Board.new(id="id", board_size=8)
    target_cell = board.select_cell_by_name("D6")

    refute target_cell.ship
    assert_equal ".", target_cell.value

    board.place_ship_on_cell("D6", "Q")

    assert target_cell.ship
    assert_equal "Q", target_cell.value
  end

  def test_board_can_reassign_value_of_its_grid_via_grid_method
    board = Board.new

    assert board.grid.instance_of? Array

    board.grid = "pie"

    assert_equal "pie", board.grid
  end

  def test_board_tracks_hits_to_its_fleet
    board = Board.new

    assert_equal 0, board.hits

    board.fleet_hit
    board.fleet_hit

    assert_equal 2, board.hits
  end

  def test_board_can_report_game_lost_by_hits
    board = Board.new

    refute board.lost_game?

    5.times do
      board.fleet_hit
    end

    assert board.lost_game?
  end

end
