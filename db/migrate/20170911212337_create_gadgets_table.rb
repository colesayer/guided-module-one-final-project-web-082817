class CreateGadgetsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :gadgets do |t|
      t.string :name
      t.integer :brains
      t.integer :brawn
      t.integer :heart
    end
  end
end
