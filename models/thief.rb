class Thief
	attr_accessor :brains, :brawn, :heart
	attr_reader :name
	
	ALL = []

	def initialize(name)
		@name   = name
		@brains = 7 
		@brawn  = 7 
		@heart  = 7 
		ALL << self
	end

	def self.all 
		ALL 
	end 

end 