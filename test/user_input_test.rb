require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/user_input'
require 'pry'

class UserInputTest < Minitest::Test

  def test_convert_array_to_appropriate_length_produces_accurate_two_cell_array
    input = UserInput.new
    array = ["A1", "A2"]
    ship_length = 2
    correct_array = input.convert_array_to_appropriate_length(array, ship_length)

    assert_equal array, correct_array
  end

  def test_convert_array_to_appropriate_length_produces_accurate_three_cell_array
    input = UserInput.new
    array = ["A1", "A3"]
    ship_length = 3
    correct_array = input.convert_array_to_appropriate_length(array, ship_length)

    assert_equal ["A1", "A2", "A3"], correct_array
  end

  def test_two_coordinates_verifies_array_size
    input = UserInput.new

    refute input.two_coordinates_provided(["A1"])
    refute input.two_coordinates_provided(["dog"])
    assert input.two_coordinates_provided(["A1", "A3"])
  end

  def test_coordinates_are_two_characters_long_verifies_all_coordinates_length_of_two
    input = UserInput.new

    assert input.coordinates_are_two_characters_long(["A1"])
    assert input.coordinates_are_two_characters_long(["A1", "Z1"])
    refute input.coordinates_are_two_characters_long(["A1", "A"])
  end

  def test_vertical_ship_orientation_detected_by_method
    input = UserInput.new

    assert input.vertical_ship_orientation(["A1", "B1"])
    refute input.vertical_ship_orientation(["A1", "A2"])
    assert input.horizontal_ship_orientation(["A1", "A2"])
    refute input.horizontal_ship_orientation(["A1", "B1"])
  end

  def test_ship_length_and_placement_range_compatible
    input = UserInput.new

    assert input.that_line_is_the_right_length(["A1", "A2"], 2)
    assert input.that_line_is_the_right_length(["A3", "C3"], 3)
    refute input.that_line_is_the_right_length(["A1", "A2"], 3)
    refute input.that_line_is_the_right_length(["A3", "C3"], 2)
  end

end
