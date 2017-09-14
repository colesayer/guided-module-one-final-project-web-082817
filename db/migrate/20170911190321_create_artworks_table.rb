class CreateArtworksTable < ActiveRecord::Migration[5.1]
  def change

  	create_table :artworks do |t| 
  		t.string :object_id 
  		t.string :title 
  		t.string :artist
  		t.integer :date 
  		t.text :description 
  		t.string :image_url
  	end 

  end
end
