class CreateRooks < ActiveRecord::Migration
  def change
    create_table :rooks do |t|
      t.string :position

      t.timestamps null: false
    end
  end
end
