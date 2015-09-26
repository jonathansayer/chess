class CreatePawns < ActiveRecord::Migration
  def change
    create_table :pawns do |t|
      t.string :position

      t.timestamps null: false
    end
  end
end
