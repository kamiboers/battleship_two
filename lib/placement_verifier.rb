module PlacementVerifier


  def vet_ship_placement(array, ship)
    if !two_coordinates_provided(array)
      display_not_two_coordinates_error
      return_to_prompt(ship.length)
    elsif !coordinates_are_two_characters_long(array)
      display_wrong_coordinate_length_error
      return_to_prompt(ship.length)
    elsif !values_included_in_board(array)
      display_bad_cell_name_error
      return_to_prompt(ship.length)
    elsif !cells_lie_in_a_line_of_some_length(array)
      display_nonconsecutive_coordinate_error
      return_to_prompt(ship.length)
    elsif !right_length_for_ship(array, ship)
      display_wrong_ship_length_coordinate_error
      return_to_prompt(ship.length)
    elsif !all_values_unoccupied?(array)
      display_occupied_cell_error
      return_to_prompt(ship.length)
    else
      array = convert_array_to_appropriate_length(array, ship.length)
      accept_and_place_ship(array, ship)
    end
  end

  def return_to_prompt(ship_length)
    if ship_length == 2
      first_ship_placement_sequence
    elsif ship_length == 3
      second_ship_placement_sequence
    end
  end

  def two_coordinates_provided(array)
    array.length == 2
  end

  def coordinates_are_two_characters_long(array)
    (array.map { |cell| cell.length == 2 }).all?
  end

  def right_length_for_ship(array, ship)
    cells_lie_in_a_line_of_some_length(array) && that_line_is_the_right_length(array, ship.length)
  end

  def values_included_in_board(array)
    (array - @user_board.possible_positions).empty?
  end

  def cells_lie_in_a_line_of_some_length(array)
    vertical_ship_orientation(array) || horizontal_ship_orientation(array)
  end

  def vertical_ship_orientation(array)
    array.first[1] == array.last[1]
  end

  def horizontal_ship_orientation(array)
    array.first[0] == array.last[0]
  end

  def that_line_is_the_right_length(array, ship_length)
    if ship_length == 2
      verify_length_two_ship(array)
    elsif ship_length == 3
      verify_length_three_ship(array)
    end
  end

  def verify_length_two_ship(array)
    if vertical_ship_orientation(array)
      array.first[0].next == array.last[0]
    elsif horizontal_ship_orientation(array)
      array.first[1].next == array.last[1]
    end
  end

  def verify_length_three_ship(array)
    if vertical_ship_orientation(array)
      array.first[0].next.next == array.last[0]
    elsif horizontal_ship_orientation(array)
      array.first[1].next.next == array.last[1]
    end
  end


  def all_values_unoccupied?(ship_array)
    viability_of_spaces = ship_array.map do |cell_name|
      cell = @user_board.select_cell_by_name(cell_name)
      cell.ship == false
    end
    !viability_of_spaces.include?(false)
  end

  def values_present_on_board?(values_array)
    (values_array-@user_board.possible_positions).empty?
  end
end
