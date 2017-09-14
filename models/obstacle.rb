class Obstacle < ActiveRecord::Base
	has_many :solutions
	has_many :gadgets, through: :solutions

	def formatted_name
		self.name.split("_").map(&:capitalize).join(" ")
	end 
end
