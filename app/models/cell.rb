class Cell < ActiveRecord::Base
  belongs_to :board

  def change_occupied_mode
    self.update_column('occupied?', !self.occupied?)
  end
end
