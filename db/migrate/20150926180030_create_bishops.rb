class CreateBishops < ActiveRecord::Migration
  def change
    create_table :bishops do |t|
      t.string :position

      t.timestamps null: false
    end
  end
end
