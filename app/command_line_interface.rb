def welcome
	puts "THIEF: Milkmaid Heist\n\n"
end

def display_museum
	url = "https://i.imgur.com/UPNE4Ox.jpg"
	a = AsciiArt.new(url)
	puts a.to_ascii_art(color: true)
end

def context
	string = "Amsterdam. 2005. The Rijksmuseum is undergoing major renovations. Giving you, Vince Peruggi, international art thief extraordinaire, a golden opportunity.\n\n"
	string.each_char do |c|
		print c
		sleep(0.030)#######################
	end
	puts " "
	"Prepare for: ".each_char do |c|
			print c
			sleep(0.035)########################
		end
	"THE MILKMAID HEIST\n".each_char do |c|
		print c
		sleep(0.12)######################
	end
end

def enter_to_begin
	msg = "PRESS ENTER TO BEGIN"

	100.times do
	  print "\r#{ msg }"
	  sleep 0.5
	  print "\r#{ ' ' * msg.size }"
	  begin
 			Timeout::timeout(0.5) do
    	return if gets.chomp
  	end
		rescue Timeout::Error
		end
	end
end

def choose_gadgets
	puts " "
	"Heist preparation".each_char do |c|
		print c
		sleep(0.025)#########################
	end
	puts "\n-------------------------------------------"
	puts "Select your gadgets:"
	Gadget.all.each_with_index {|gadget, i| puts "#{i+1}. #{gadget.formatted_name}"}
	puts "-------------------------------------------\n\n"
end

def select_five_gadgets
	until Display.gadgets.length == 5
	selection = get_user_input

		unless (1..9).to_a.include?(selection.to_i)
			puts "That's not on the list, are you sure you're up for this?\n\n"
			enter_num
			next
		end

		gadget = Gadget.all[selection.to_i-1]
		if Display.gadgets.include?(gadget)
			puts "You already have #{gadget.formatted_name}.\n\n"
		else
			Display.add_gadget(gadget)
			puts "You selected: #{gadget.formatted_name}.\n\n"
		end

		print "ENTER A NUMBER TO SELECT YOUR NEXT GADGET: "
	end
end

def enter_num
	print "ENTER A NUMBER TO SELECT A GADGET: "
end

def entrypoint_description
	string = "You find yourself standing in front of the illustrious Rijksmuseum. Its glorious facade towers before you. Your hair stands on end as you think about the invaluable masterpieces that lie within. Your adrenaline begins to surge, your body knows it is time for the heist. You examine the museum, assessing your entrypoints."
	type(string)
	type("\nThere is SCAFFOLDING on the left end of the building giving access to third floor windows.")
end

def type(string)
	sentences = string.split(".").compact
	sentences.each do |string|
		string.strip.each_char do |c|
			print c
			sleep(0.025)     #######################
		end
		print "."
		sleep(0.025)       #######################
		puts " "
	end
end

def get_entrypoint
	puts "\nWhat's your move?"
	input = get_user_input.downcase

	until input.split.include?("scaffolding")
		puts "Nope. But the SCAFFOLDING looks pretty promising.\n\n"
		puts "What's your move?"
		input = get_user_input.downcase
	end
	input
end

def scaffolding_entry
	string = "You head over to the scaffolding and start to ascend. The city lights of Amsterdam illuminate your path. An open window at the top gives easy access. You climb through the window landing on the hard parquet floor."
	type(string)
	sleep(0.5)
	puts "WAIT!!!"
	sleep(1)
end

def get_obstacle
	obstacle = Obstacle.all.sample
	while Display.obstacles.include?(obstacle)
		obstacle = Obstacle.all.sample
	end
	Display.add_obstacle(obstacle)
	CurrentObstacle.new(obstacle.id, obstacle.name, obstacle.brains, obstacle.brawn, obstacle.heart, obstacle.failure)
	puts " "
	type(obstacle.description)
	sleep(1)
	obstacle
end

def select_gadget_for_obstacle
	input = "poo"
	until valid?(input)
		puts "\nChoose a gadget to deal with this obstacle.\n"
		sleep(0.25)
		Display.display_gadgets
		puts "\nENTER A NUMBER TO SELECT A GADGET"
		puts "or"
		print "ENTER 'NONE' TO RELY ON YOUR OWN SKILL: "
		input = get_user_input
	end

	if input.downcase == "none"
		input.downcase
	else
		Display.gadgets[input.to_i-1]
	end
end

def any_gadget_solutions?(obstacle)
	gadget_solutions = Solution.all.select {|sol| sol.obstacle_id == obstacle.id}
	solution_gadget_ids = gadget_solutions.map(&:gadget_id)
	thief_gadget_ids = Display.gadgets.map(&:id)

	!(solution_gadget_ids & thief_gadget_ids).empty?
end

def enough_base_stats?(thief, obstacle)
	obstacle.brains <= thief.brains && obstacle.brawn <= thief.brawn && obstacle.heart <= thief.heart
end

def valid?(input)

	if (1..Display.gadgets.length).to_a.include?(input.to_i)
		true
	elsif input.downcase == "none"
		true
	else
		false
	end
end

def find_working_gadget(selection)
	current_obstacle = CurrentObstacle.all.last
	current_obstacle_id = CurrentObstacle.all.last.id
	obstacle_solutions = Solution.all.select {|solution| solution.obstacle_id == current_obstacle_id}
	solution_gadget = obstacle_solutions.find {|solution| solution.gadget_id == selection.id}

	if solution_gadget != nil
		gadget = Gadget.find(solution_gadget.gadget_id)
		current_obstacle.brains -= gadget.brains
		current_obstacle.brawn -= gadget.brawn
		current_obstacle.heart -= gadget.heart
		puts "You used: #{gadget.formatted_name}.\n"
		Display.gadgets.delete(gadget)
		if obstacle_overcome?(current_obstacle) == false
			puts "The #{gadget.formatted_name} has some effect, but is not enough.\n"
		end
	else
		puts "That gadget can't be used here.\n"
		sleep(0.005)
	end

	  current_obstacle
end

def use_base_stats(thief, obstacle)
	thief.brains -= obstacle.brains
	thief.brawn -= obstacle.brawn
	thief.heart -= obstacle.heart
end

def obstacle_overcome?(obstacle)
	obstacle.brains <= 0 && obstacle.brawn <= 0 && obstacle.heart <= 0
end

def overcome_obstacle(obstacle, gadget)
	obstacle_solutions = Solution.all.select {|solution| solution.obstacle_id == obstacle.id}
	solution = obstacle_solutions.find {|solution| solution.gadget_id == gadget.id}
	if solution != nil
		string = solution.description
		string.each_char do |c|
			print c
			sleep(0.025)
		end
	end
	puts " "
end

def overcome_using_base_stats
	string = "Your skills as a thief prove worthy. Your efforts, however, have taken a toll on your body, mind, and willpower."
	string.each_char do |c|
		print c
		sleep(0.025)
	end
end

def enter_new_corridor(current_obstacle)
	puts " "
	string = "Safely past the #{current_obstacle.formatted_name}, you enter a beautiful corridor. There is art to your LEFT and to your RIGHT. The corridor extends FORWARD."
	type(string)
	puts "\nWhat is your move?"
end

def display_milkmaid
	milkmaid = Artwork.find_by(title: "The Milkmaid")
	url = milkmaid.image_url
	a = AsciiArt.new(url)
	puts a.to_ascii_art(color: true, width: 60)
	puts "#{milkmaid.title}, #{milkmaid.artist}"
end

def enter_milkmaid_gallery(current_obstacle)
	puts " "
	string = "Safely past the #{current_obstacle.formatted_name}, you enter a spectacular and breathtaking gallery. The columns lining your path lead to a large and glorious wall at the end of the arcade. Hanging on the wall, bathed in magestic light, is the object of your desire: THE MILKMAID!"
	type(string)
	sleep(2.5)
	system "clear"
	display_milkmaid
	sleep(1)
	puts "\nSTEAL \"The Milkmaid\"?"
end

def corridor
	puts " "
	string = "You are standing in a beautiful corridor. There is art to your LEFT and to your RIGHT. The corridor extends FORWARD."
	type(string)
	puts "\nWhat is your move?"
end

def corridor_decision(artwork_left, left_value, artwork_right, right_value)
	corridor
	input = get_user_input
	if input.downcase.split.include?("left")
		corridor_left(artwork_left, left_value)
	elsif input.downcase.split.include?("right")
		corridor_right(artwork_right, right_value)
	elsif !input.downcase.split.include?("forward")
		corridor_invalid
	end
	input
end

def corridor_left(artwork_left, value)
	if Display.artworks.include?(artwork_left)
		type("You already took the painting from this wall.")
		sleep(0.5)
	else
		url = artwork_left.image_url
		a = AsciiArt.new(url)
		puts a.to_ascii_art(color: true, width: 60)
		print "#{artwork_left.title}, #{artwork_left.artist}"
		if artwork_left.date == 0
			puts " "
		else
			puts ", #{artwork_left.date}"
		end
		puts "Value: $#{value}\n\n"

		steal_artwork(artwork_left, value)
	end
end

def corridor_right(artwork_right, value)
	if Display.artworks.include?(artwork_right)
		type("You already took the painting from this wall.")
		sleep(0.5)
	else
		url = artwork_right.image_url
		a = AsciiArt.new(url)
		puts a.to_ascii_art(color: true, width: 60)
		print "#{artwork_right.title}, #{artwork_right.artist}"
		if artwork_right.date == 0
			puts " "
		else
			puts ", #{artwork_right.date}"
		end
		puts "Value: $#{value}\n\n"
		steal_artwork(artwork_right, value)
	end
end

def corridor_invalid
	puts "Nope. LEFT, RIGHT, and FORWARD seem like viable options."
end

def steal_artwork(artwork, value)
	alarm_num = 2
	puts "Attempt to STEAL \"#{artwork.title}\" or GO BACK TO CORRIDOR?"
	input = get_user_input
	while "poop"
		if input.downcase.split.include?("steal") || input.downcase.split.include?("yes")
			random_num = rand(1..2)
			alarm_result = artwork_alarm(Thief.all.first) if random_num == alarm_num
			if alarm_result == nil || alarm_result == true
				Display.steal(artwork, value)
				puts "You have stolen \"#{artwork.title}\". You have a total of $#{Display.value} in stolen artwork."
			end
			break
		elsif input.downcase.split.include?("no") || input.downcase.split.include?("go") || input.downcase.split.include?("back") || input.downcase.split.include?("corridor")
			#do nothing
			break
		else
			puts "Nope, but maybe you want to STEAL or GO BACK TO CORRIDOR?"
			input = get_user_input
		end
	end
end

def artwork_alarm(thief)
    string = "You've set off an alarm! Type 'x' to disable the alarm."
    type(string)
    sleep(1.0)
    counter = 9
    9.times do
      print "\r#{counter}"
      print "\a"
      sleep(0.25)
      print "\r "
      begin
        Timeout::timeout(0.75) do
        return true if STDIN.getch == "x"
  		end
      rescue Timeout::Error
      end
      counter -= 1
    end
    thief.brains -= 2
    thief.brawn -= 2
    thief.heart -= 2
    puts "You couldn't disarm it in time. Luckily, there's no one around to hear it but you. The shame has taken its toll on your body, mind, and willpower."
    false
end

def game_over(obstacle)
	sleep(2)
	system "clear"
	string = "#{obstacle.failure} Your thieving skills were no match for your insatiable greed. You lost $#{Display.value} in stolen artwork."
	string.each_char do |c|
		print c
		sleep(0.025)
	end

	puts "  "
	msg = "GAME OVER"
	100.times do
	  print "\r#{ msg }"
	  sleep 0.5
	  print "\r#{ ' ' * msg.size }"
	  begin
 			Timeout::timeout(0.5) do
    	return if gets.chomp
  	end
		rescue Timeout::Error
		end
	end
end

def win_game
	milkmaid = Artwork.find_by(title: "The Milkmaid")
	Display.steal(milkmaid, 100000000000)
	string = "You have stolen \"The Milkmaid\"!"
	string.each_char do |c|
		print c
		sleep(0.025)
	end
	puts " "
	string = "You stole a total of $#{Display.value} worth of artwork from the Rijksmuseum, including:"
		string.each_char do |c|
		print c
		sleep(0.025)
	end
	puts " "
	sleep(1.3)
	Display.artworks.each do |art|
		display(art)
		puts "#{art.title}, #{art.artist}\n"
		sleep(1.6)
		system "clear"
	end

	system "clear"
	msg = "GAME OVER"
	100.times do
	  print "\r#{ msg }"
	  sleep 0.5
	  print "\r#{ ' ' * msg.size }"
	  begin
 			Timeout::timeout(0.5) do
    	return if gets.chomp
  	end
		rescue Timeout::Error
		end
	end
end

def display(artwork)
	url = artwork.image_url
	a = AsciiArt.new(url)
	puts a.to_ascii_art(color: true, width: 60)
end

def get_user_input
	gets.chomp
end
