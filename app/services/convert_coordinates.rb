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

  def self.convert_to_numercal_coords position
    coordinates = []
    split_position = position.split(//)
    x = @conversion_hash[split_position.first]
    y = split_position.last.to_i
    coordinates.push(x,y)
  end

  def self.convert_to_alphabetical_coords coords
    self.convert_first_number_to_letter coords
    @letter + coords.last.to_s
  end

  private

  def self.convert_first_number_to_letter coords
    @conversion_hash.each do |key,value|
      if value == coords.first
         @letter = key
        break
      end
    end
  end

end
