class CreateLineFurnitures < ActiveRecord::Migration
  def change
    create_table :line_furnitures do |t|
      t.integer :furniture_id
      t.integer :quantity
      t.decimal :price
      t.integer :sale_id
      t.timestamps
    end
  end
end
