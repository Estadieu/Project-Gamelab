extends Weapon

func get_price(lvl): return 10 * lvl

func _init():
	default_level = {
		"details": "A spear of ice is thrown at a random enemy",
		"update": func (): base_ammo += 1,
	}

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

func set_target(new_bullet):
	var targets = player.get_targets()
	
	if targets.size() == 0:
		return null

	var near_target   = targets[0]
	var near_distance = player.global_position.distance_to(targets[0].global_position)
	var distance

	for enemy in targets:
		distance = player.global_position.distance_to(enemy.global_position)
		
		if distance < near_distance:
			near_distance = distance
			near_target = enemy

	new_bullet.target = near_target
