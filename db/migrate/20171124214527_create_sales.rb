class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :payment_id
      t.integer :toal
      t.integer :encganche
      t.integer :bonificacion
      t.integer :term
      t.boolean :status
      t.timestamps
    end
  end
end
