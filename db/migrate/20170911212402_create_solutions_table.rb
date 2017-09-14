class CreateSolutionsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :solutions do |t|
      t.integer :obstacle_id
      t.integer :gadget_id
      t.text :description
    end
  end
end
