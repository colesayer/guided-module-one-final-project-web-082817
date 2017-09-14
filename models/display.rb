class Display

	@@gadgets = [] 
	@@obstacles = []
	@@artworks = []
	@@value = 0

	def self.add_gadget(gadget) 
		@@gadgets << gadget 
	end 

	def self.display_gadgets
		puts "\nYou are carrying: "
		self.gadgets.each_with_index {|gadget, i| puts "#{i+1}. #{gadget.formatted_name}"}
	end 

	def self.add_obstacle(obstacle)
		@@obstacles << obstacle
	end

	def self.obstacles 
		@@obstacles 
	end 

	def self.gadgets 
		@@gadgets
	end 

	def self.steal(artwork, value)
		@@artworks << artwork
		@@value += value
	end

	def self.artworks 
		@@artworks
	end

	def self.value
		@@value
	end

end 