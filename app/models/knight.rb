class Knight < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    @new_position = new_position
    raise 'Invalid Move' unless possible_move?
    self.position = new_position
  end

  def possible_move?
    (move_two_horizontally? and move_one_vertically?) or (move_two_vertically? and move_one_horizontally?)
  end

  private

    def move_two_horizontally?
      move_length(0) == 2
    end

    def move_one_horizontally?
      move_length(0) == 1
    end

    def move_two_vertically?
      move_length(1) == 2
    end

    def move_one_vertically?
      move_length(1) == 1
    end

    def move_length index
      (current_coords[index] - new_coords[index]).abs
    end

    def current_coords
      current_coords = ConvertCoordinates.to_numerical_coords self.position
    end

    def new_coords
      new_coords = ConvertCoordinates.to_numerical_coords @new_position
    end

end
