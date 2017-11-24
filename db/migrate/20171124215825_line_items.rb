class LineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
    	t.integer :furniture_id
      t.integer :quantity
      t.decimal :price
      t.decimal :total_price
      t.integer :sale_id
      t.timestamps
    end
  end
end
