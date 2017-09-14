class CreateObstaclesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :obstacles do |t|
      t.string :name
      t.integer :brains
      t.integer :brawn
      t.integer :heart
      t.text :description
      t.text :failure
    end
  end
end
