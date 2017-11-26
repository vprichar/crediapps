class CreateConfiguracions < ActiveRecord::Migration
  def change
    create_table :configuracions do |t|
      t.integer :sale_id
      t.decimal :financing_rate
      t.decimal :Deadline

      t.timestamps
    end
  end
end
