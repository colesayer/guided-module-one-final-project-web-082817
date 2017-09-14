require_relative '../config/environment'

thief = Thief.new("Vince")
milkmaid = Artwork.find_by(title: "The Milkmaid")

system "clear"
welcome 
display_museum 
context
enter_to_begin
system "clear"

display_museum
choose_gadgets
enter_num
select_five_gadgets 

system "clear"
entrypoint_description 
input = get_entrypoint
system "clear"
scaffolding_entry

# FIRST OBSTACLE 
current_obstacle = get_obstacle 
until obstacle_overcome?(current_obstacle)
	used_base_stats = false 
	selection = select_gadget_for_obstacle 
	if selection.is_a?(String) && selection.downcase == "none"
		use_base_stats(thief, current_obstacle)
		overcome_using_base_stats 
		used_base_stats = true
		break
	else 
		current_obstacle = find_working_gadget(selection) 
	end 
end 
overcome_obstacle(current_obstacle, selection) if used_base_stats == false 

sleep(1.5)
system "clear"

enter_new_corridor(current_obstacle)
input = get_user_input 
artwork_left = Artwork.all.sample 
artwork_left = Artwork.all.sample  if artwork_left  == milkmaid || Display.artworks.include?(artwork_left)
artwork_left = Artwork.all.sample  if artwork_left  == milkmaid || Display.artworks.include?(artwork_left)
artwork_right = Artwork.all.sample
artwork_right = Artwork.all.sample if artwork_right == milkmaid || Display.artworks.include?(artwork_right)
artwork_right = Artwork.all.sample if artwork_right == milkmaid || Display.artworks.include?(artwork_right)
left_value  = rand(10000..20000)
right_value = rand(10000..20000)

if input.downcase.split.include?("left")
	corridor_left(artwork_left, left_value)
elsif input.downcase.split.include?("right")
	corridor_right(artwork_right, right_value)
end 

until input.downcase.split.include?("forward")
	input = corridor_decision(artwork_left, left_value, artwork_right, right_value)
end 
sleep(1.5)
system "clear"

# SECOND OBSTACLE
current_obstacle = get_obstacle 
if !any_gadget_solutions?(current_obstacle) && !enough_base_stats?(thief, current_obstacle)
	game_over(current_obstacle)
	exit 
end 

until obstacle_overcome?(current_obstacle)
	if !any_gadget_solutions?(current_obstacle) && !enough_base_stats?(thief, current_obstacle)
		game_over(current_obstacle)
		exit 
	end 
	used_base_stats = false 
	selection = select_gadget_for_obstacle 
	if selection.is_a?(String) && selection.downcase == "none"
		if enough_base_stats?(thief, current_obstacle)
			use_base_stats(thief, current_obstacle)
			overcome_using_base_stats
			used_base_stats = true
			break
		else 
			puts "You do not have enough skill, try something else."
		end
	else 
		current_obstacle = find_working_gadget(selection) 
	end 
end 
overcome_obstacle(current_obstacle, selection) if used_base_stats == false 

sleep(1.5)
system "clear"

enter_new_corridor(current_obstacle)
input = get_user_input  
artwork_left = Artwork.all.sample 
artwork_left = Artwork.all.sample  if artwork_left  == milkmaid || Display.artworks.include?(artwork_left)
artwork_left = Artwork.all.sample  if artwork_left  == milkmaid || Display.artworks.include?(artwork_left)
artwork_right = Artwork.all.sample
artwork_right = Artwork.all.sample if artwork_right == milkmaid || Display.artworks.include?(artwork_right)
artwork_right = Artwork.all.sample if artwork_right == milkmaid || Display.artworks.include?(artwork_right)
left_value  = rand(20000..30000)
right_value = rand(20000..30000)

if input.downcase.split.include?("left")
	corridor_left(artwork_left, left_value)
elsif input.downcase.split.include?("right")
	corridor_right(artwork_right, right_value)
end 

until input.downcase.split.include?("forward")
	input = corridor_decision(artwork_left, left_value, artwork_right, right_value)
end 
sleep(1.5)
system "clear"

# THIRD OBSTACLE 
current_obstacle = get_obstacle 
if !any_gadget_solutions?(current_obstacle) && !enough_base_stats?(thief, current_obstacle)
	game_over(current_obstacle)
	exit 
end 

until obstacle_overcome?(current_obstacle)
	if !any_gadget_solutions?(current_obstacle) && !enough_base_stats?(thief, current_obstacle)
		game_over(current_obstacle)
		exit 
	end 
	used_base_stats = false 
	selection = select_gadget_for_obstacle 
	if selection.is_a?(String) && selection.downcase == "none"
		if enough_base_stats?(thief, current_obstacle)
			use_base_stats(thief, current_obstacle)
			overcome_using_base_stats
			used_base_stats = true
			break
		else 
			puts "You do not have enough skill, try something else."
		end
	else 
		current_obstacle = find_working_gadget(selection) 
	end 
end 
overcome_obstacle(current_obstacle, selection) if used_base_stats == false 

sleep(1.5)
system "clear"

enter_new_corridor(current_obstacle)
input = get_user_input 
artwork_left = Artwork.all.sample 
artwork_left = Artwork.all.sample  if artwork_left  == milkmaid || Display.artworks.include?(artwork_left)
artwork_left = Artwork.all.sample  if artwork_left  == milkmaid || Display.artworks.include?(artwork_left)
artwork_right = Artwork.all.sample
artwork_right = Artwork.all.sample if artwork_right == milkmaid || Display.artworks.include?(artwork_right)
artwork_right = Artwork.all.sample if artwork_right == milkmaid || Display.artworks.include?(artwork_right)
left_value  = rand(30000..40000)
right_value = rand(30000..40000)

if input.downcase.split.include?("left")
	corridor_left(artwork_left, left_value)
elsif input.downcase.split.include?("right")
	corridor_right(artwork_right, right_value)
end 

until input.downcase.split.include?("forward")
	input = corridor_decision(artwork_left, left_value, artwork_right, right_value)
end 
sleep(1.5)
system "clear"

# FOURTH OBSTACLE 
current_obstacle = get_obstacle 
if !any_gadget_solutions?(current_obstacle) && !enough_base_stats?(thief, current_obstacle)
	game_over(current_obstacle)
	exit 
end 

until obstacle_overcome?(current_obstacle)
	if !any_gadget_solutions?(current_obstacle) && !enough_base_stats?(thief, current_obstacle)
		game_over(current_obstacle)
		exit 
	end 
	used_base_stats = false 
	selection = select_gadget_for_obstacle 
	if selection.is_a?(String) && selection.downcase == "none"
		if enough_base_stats?(thief, current_obstacle)
			use_base_stats(thief, current_obstacle)
			overcome_using_base_stats
			used_base_stats = true
			break
		else 
			puts "You do not have enough skill, try something else."
		end
	else 
		current_obstacle = find_working_gadget(selection) 
	end 
end 
overcome_obstacle(current_obstacle, selection) if used_base_stats == false 

sleep(1.5)
system "clear"

enter_new_corridor(current_obstacle)
input = get_user_input 
artwork_left = Artwork.all.sample 
artwork_left = Artwork.all.sample  if artwork_left  == milkmaid || Display.artworks.include?(artwork_left)
artwork_left = Artwork.all.sample  if artwork_left  == milkmaid || Display.artworks.include?(artwork_left)
artwork_right = Artwork.all.sample
artwork_right = Artwork.all.sample if artwork_right == milkmaid || Display.artworks.include?(artwork_right)
artwork_right = Artwork.all.sample if artwork_right == milkmaid || Display.artworks.include?(artwork_right)
left_value  = rand(40000..50000)
right_value = rand(40000..50000)

if input.downcase.split.include?("left")
	corridor_left(artwork_left, left_value)
elsif input.downcase.split.include?("right")
	corridor_right(artwork_right, right_value)
end 

until input.downcase.split.include?("forward")
	input = corridor_decision(artwork_left, left_value, artwork_right, right_value)
end 
sleep(1.5)
system "clear"

# FIFTH OBSTACLE 
current_obstacle = get_obstacle 
if !any_gadget_solutions?(current_obstacle) && !enough_base_stats?(thief, current_obstacle)
	game_over(current_obstacle)
	exit 
end 

until obstacle_overcome?(current_obstacle)
	if !any_gadget_solutions?(current_obstacle) && !enough_base_stats?(thief, current_obstacle)
		game_over(current_obstacle)
		exit 
	end 
	used_base_stats = false 
	selection = select_gadget_for_obstacle 
	if selection.is_a?(String) && selection.downcase == "none"
		if enough_base_stats?(thief, current_obstacle)
			use_base_stats(thief, current_obstacle)
			overcome_using_base_stats
			used_base_stats = true
			break
		else 
			puts "You do not have enough skill, try something else."
		end
	else 
		current_obstacle = find_working_gadget(selection) 
	end 
end 
overcome_obstacle(current_obstacle, selection) if used_base_stats == false 

sleep(1.5)
system "clear"

###########
#MILKMAID HALLWAY 
enter_milkmaid_gallery(current_obstacle)
input = get_user_input 
until input.downcase.split.include?("steal")
	puts "\nNope. Do you wanna maybe STEAL \"The Milkmaid\"?"
	input = get_user_input
end 
sleep(1.5) 
system "clear"
win_game
##############







