class Knight < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    @new_position = new_position
    raise 'Invalid Move' unless possible_move?
    self.position = new_position
  end

  def possible_move?
    (move_two_in_dimension?(0) and move_one_in_dimension?(1)) or (move_two_in_dimension?(1) and move_one_in_dimension?(0))
  end

  private

    def move_two_in_dimension? index
      move_length(index) == 2
    end

    def move_one_in_dimension? index
      move_length(index) == 1
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
