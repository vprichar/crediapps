class CreateFurnitures < ActiveRecord::Migration
  def change
    create_table :furnitures do |t|
      t.string :barcode
      t.string :name
      t.text :description
      t.decimal :price, precision: 8, scale: 2
      t.decimal :cost_price, precision: 8, scale: 2
      t.boolean :status
      t.timestamps
    end
  end
end
