extends Weapon

#function to get the price of the snowball based on the level
func get_price(lvl): return 10 * lvl + 10


func _init():
	#default level configuration for the snowball
	default_level = {
		"details": "A snowball is created and random heads somewhere in the players direction",
		"update": func (): base_ammo += 1,
	}
	 # Configuration for level 2 of the snowball
	levels = {
		'2': {
			"details": "The snow ball cooldown is reduced by 1 second",
			"update": func (): base_cooldown -= 1,
		}
	}

# Function to get target positions based on a count
func get_targets(count):
	var result = []
	# Loop to generate target positions
	for _i in range(count):
		# Append position based on player's global position and last movement
		result.append(player.global_position + player.last_movement)

	return result
