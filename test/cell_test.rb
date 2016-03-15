require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/cell'
require 'pry'

class CellTest < Minitest::Test

  def test_cell_instantiates_with_default_values
    cell = Cell.new

    assert_equal ".", cell.value
    refute cell.ship
    refute cell.name
  end

  def test_cell_can_instantiate_with_attribute_values
    cell = Cell.new(value="Z", ship=true, name="R7")

    assert_equal "Z", cell.value
    assert_equal true, cell.ship
    assert_equal "R7", cell.name
  end

end
