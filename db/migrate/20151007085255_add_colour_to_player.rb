class AddColourToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :colour, :string
    add_column :players, :status, :string
  end
end
