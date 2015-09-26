class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.string :position
      t.boolean :occupied?

      t.timestamps null: false
    end
  end
end
