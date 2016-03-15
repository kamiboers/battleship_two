require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/battleship'
require 'pry'

class BattleshipTest < Minitest::Test

  def test_battleship_instantiates
    battleship = Battleship.new

    assert battleship.instance_of? Battleship
  end

end
