class CreateKings < ActiveRecord::Migration
  def change
    create_table :kings do |t|
      t.string :position

      t.timestamps null: false
    end
  end
end
