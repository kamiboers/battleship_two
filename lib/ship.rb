require 'pry'
class Ship

  attr_reader :length, :sunk, :filler, :hits, :cells, :name

  def initialize(name="Boat", length=2, filler="T")
    @name = name
    @length = length
    @filler = filler
    @hits = 0
    @sunk = false
    @cells = []
  end

  def hit
    if !self.sunk
      @hits += 1
    end
  end

  def sunk
    @sunk = (@hits == @length)
  end

  def add_placement_cell(cell)
    @cells << cell
  end

end
