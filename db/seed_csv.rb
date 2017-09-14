require_relative '../config/environment.rb'


CSV.foreach("csv/gadgets.csv").with_index do |row, i|
  if i != 0
    attrs = {
      name: row[0],
      brains: row[1],
      brawn: row[2],
      heart: row[3]
    }
    Gadget.create(attrs)
  end
end

CSV.foreach("csv/obstacles.csv").with_index do |row, i|
  if i != 0
    attrs = {
      name: row[0],
      brains: row[1],
      brawn: row[2],
      heart: row[3],
      description: row[4],
      failure: row[5]
    }
    Obstacle.create(attrs)
  end
end

CSV.foreach("csv/solutions.csv").with_index do |row, i|
  if i != 0
    attrs = {
      obstacle_id: row[0],
      gadget_id: row[1],
      description: row[2]
    }
    Solution.create(attrs)
  end
end
