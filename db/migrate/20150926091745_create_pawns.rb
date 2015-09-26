class CreatePawns < ActiveRecord::Migration
  def change
    create_table :pawns do |t|
      t.string :position
      t.integer :move_limit
      t.boolean :horizontal?
      t.boolean :vertical?
      t.boolean :diagonal?

      t.timestamps null: false
    end
  end
end
