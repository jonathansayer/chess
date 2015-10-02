class ConvertCoordinates

  @conversion_hash = {'A' => 1,
                      'B' => 2,
                      'C' => 3,
                      'D' => 4,
                      'E' => 5,
                      'F' => 6,
                      'G' => 7,
                      'H' => 8
                      }

  def self.to_numerical_coords *positions
    coordinates = []
    positions.each do |position|
      split_position = position.split(//)
      x = @conversion_hash[split_position.first]
      y = split_position.last.to_i
      coordinates.push([x,y])
    end
    return coordinates.first if coordinates.length == 1
    coordinates
  end

  def self.to_alphabetical_coords *coords
    position_array = []
    coords.each do |coordinate|
      self.first_number_to_letter coordinate
        position_array.push(@letter + coordinate.last.to_s)
      end
      return position_array.first if position_array.length == 1
      position_array
  end

  private

  def self.first_number_to_letter coords
    @conversion_hash.each do |key,value|
      if value == coords.first
         @letter = key
        break
      end
    end
  end

end
