require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/battleship'
require 'pry'

class ReplTest < Minitest::Test

  def test_input_can_be_verified_as_instructions
    b = Battleship.new

    assert b.input_is_instructions?("i")
    assert b.input_is_instructions?("instructions")
    refute b.input_is_instructions?("play")
  end

  def test_input_can_be_verified_as_play
    b = Battleship.new

    assert b.input_is_play?("p")
    assert b.input_is_play?("play")
    refute b.input_is_play?("i")
  end

  def test_initial_input_can_be_validated
    b = Battleship.new

    assert b.valid_initial_input?("i")
    assert b.valid_initial_input?("p")
    assert b.valid_initial_input?("play")
    refute b.valid_initial_input?("pla")
  end

  def test_ship_placement_input_splits_ship_placement_into_array
    b = Battleship.new
    placement_array = b.ship_placement_input("A3 B3 C3")

    assert_equal ["A3", "B3", "C3"], placement_array
  end

  def test_ship_placement_array_is_case_insensitive_for_input
    b = Battleship.new
    placement_array = b.ship_placement_input("a3 b3 C3")

    assert_equal ["A3", "B3", "C3"], placement_array
  end

  def test_ship_placement_input_sorts_ship_placement_in_array
    b = Battleship.new
    placement_array = b.ship_placement_input("B3 C3 A3")

    assert_equal ["A3", "B3", "C3"], placement_array
  end

end
