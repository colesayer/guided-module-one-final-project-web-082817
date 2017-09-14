require 'bundler/setup'
Bundler.require
require 'csv'
require 'open-uri'
require 'timeout'
require_relative '../app/models/gadget.rb'
require_relative '../app/models/solution.rb'
require_relative '../app/models/obstacle.rb'
require_relative '../app/models/thief.rb'
require_relative '../app/models/artwork.rb'
require_relative '../app/models/display.rb'
require_relative '../app/models/current_obstacle.rb'
require_relative '../app/command_line_interface.rb'

ActiveRecord::Base.logger = nil 

DB = ActiveRecord::Base.establish_connection(
	adapter: 'sqlite3',
	database: 'db/museum.db'
)
