require 'pry'
require_relative 'ship'
require_relative 'cell'
require_relative 'text_interface'

class Board
  include TextInterface

  attr_reader :grid, :possible_positions, :row_headings, :ships, :hits, :opponent_id

  def initialize(opponent_id="id", board_size=4)
    @board_size = board_size
    @hits = 0
    @ships = []
    @opponent_id = opponent_id
    compose_board
  end

  def compose_board
    assign_row_headings
    place_cells_in_grid
    assign_cell_coordinates
    store_possible_positions
  end

  def assign_row_headings
    @row_headings = ("A".."Z").first(@board_size)
  end

  def place_cells_in_grid
    @grid = Array.new(@board_size).map do |row|
      Array.new(@board_size).map do |space|
        Cell.new
      end
    end
  end

  def assign_cell_coordinates
    (0...@board_size).each do |y_pos|
      (0...@board_size).each do |x_pos|
        cell = (@grid[y_pos][x_pos])
        cell.name = @row_headings[y_pos] + (x_pos+1).to_s
      end
    end
  end

  def store_possible_positions
    @grid = @grid.flatten
    @possible_positions = @grid.map { |cell| cell.name }
  end

  def display_board
    frame_length = (@board_size*2.75)
    puts "=" * frame_length
    puts ". #{[*1..@board_size].join(" ")}"
    display_board_rows
    puts "=" * frame_length
  end

  def display_board_rows
    cutoff = @board_size - 1
    row_num = 0
    print "#{@row_headings[row_num]}"
    @grid.each_with_index do |cell, index|
      if index != 0 && index % cutoff == 0
        row_num += 1
        cutoff += @board_size
        print " " + cell.value + "\n#{@row_headings[row_num]}"
      else
        print " " + cell.value
      end
    end
  end

  def select_cell_by_name(cell_name)
    self.grid.flatten.find do |cell|
        cell.name == cell_name
    end
  end

  def place_ship_on_cell(cell_name, filler="S")
      @grid = self.grid.map do |cell|
          if cell.name == cell_name && cell.ship == false
            cell.ship = true
            cell.value = filler
          end
            cell
      end
    end

  def grid=(altered_grid)
    @grid = altered_grid
  end

  def fleet_hit
    @hits += 1
  end

  def lost_game?
    @hits == 5
  end

  def ships_hit(shot_cell)
    ship_cells_record_hit(shot_cell)
    sunken_ship = ships_sunk?
    display_sunken_ship_message(sunken_ship)
    @ships.delete(sunken_ship)
  end

  def ship_cells_record_hit(shot_cell)
    self.fleet_hit
    @ships = @ships.map do |ship|
      ship.hit if ship.cells.include?(shot_cell)
      ship
    end
  end

  def ships_sunk?
    @ships.find do |ship|
    ship.sunk
    end
  end

end
