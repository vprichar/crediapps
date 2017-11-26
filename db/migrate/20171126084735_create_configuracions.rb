class CreateConfiguracions < ActiveRecord::Migration
  def change
    create_table :configuracions do |t|
      t.decimal :financing_rate
      t.decimal :deadline
      t.decimal :hitch
      t.integer :sale_id
      

      t.timestamps
    end
  end
end
