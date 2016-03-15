require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/ship'
require 'pry'

class ShipTest < Minitest::Test

  def test_ship_instantiates_with_default_values
    ship = Ship.new

    assert_equal "Boat", ship.name
    assert_equal 2, ship.length
    assert_equal "T", ship.filler
    assert_equal 0, ship.hits
    refute ship.sunk
    assert ship.cells.empty?
  end

  def test_ship_can_be_passed_attributes_when_instantiated
    ship = Ship.new(name="Sub", length=3, filler="S")

    assert_equal "Sub", ship.name
    assert_equal 3, ship.length
    assert_equal "S", ship.filler
    assert_equal 0, ship.hits
    refute ship.sunk
    assert ship.cells.empty?
  end

  def test_ship_counts_hits_until_sunk
    ship = Ship.new(name="Destroyer", length=3)
    ship.hit
    ship.hit

    assert_equal 2, ship.hits
    refute ship.sunk

    ship.hit

    assert_equal 3, ship.hits
    assert ship.sunk
  end

  def test_ship_can_add_placement_cells
    ship = Ship.new

    assert ship.cells.empty?

    ship.add_placement_cell("A3")
    ship.add_placement_cell("B3")

    assert_equal ["A3", "B3"], ship.cells
  end

end
