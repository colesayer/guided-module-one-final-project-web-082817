class Gadget  < ActiveRecord::Base
	has_many :solutions
	has_many :obstacles, through: :solutions

	def self.formatted_names 
		self.all.map do |gadget| 
			gadget.name.split("_").map(&:capitalize).join(" ")
		end
	end 

	def formatted_name 
		self.name.split("_").map(&:capitalize).join(" ")
	end 

end
