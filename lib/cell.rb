require 'pry'

class Cell
  attr_reader :value, :ship, :name

  def initialize(value=".", ship=false, name=nil)
    @value = value
    @ship = ship
    @name = name
  end

  def value=(new_value)
    @value = new_value
  end

  def name=(new_name)
    @name = new_name
  end

  def ship=(new_status)
    @ship = new_status
  end
  
end
