extends Weapon

# Compute price
func get_price(lvl): return 10 * lvl

func _init():
	# Init default level
	default_level = {
		"details": "A spear of ice is thrown at a random enemy",
		"update": func (): base_ammo += 1,
	}

	# Init custom levels
	levels = {
		'2': {
			"details": "Ice Spears now pass through another enemy and do +5 damage",
			"update": func ():
				base_stats['max_hp']  = 10
				base_stats['damage'] += 5,
		},
		'3': {
			"details": "An additional 2 Ice Spears are thrown",
			"update": func (): base_ammo += 2,
		}
	}

# Targets sort function
func sort_closest(a, b): 
	# Sort ASC by distance between player and enemies
	return player.global_position.distance_to(a.global_position) <= player.global_position.distance_to(b.global_position)

func get_targets(_count):
	var result = player.get_targets() # Get all detected enemies
	result.sort_custom(sort_closest) # Sort by closest enemies

	return result
