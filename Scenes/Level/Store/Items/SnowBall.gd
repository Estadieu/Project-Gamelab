extends Weapon

func get_price(lvl): return 10 * lvl + 10

func _init():
	default_level = {
		"details": "A snowball is created and random heads somewhere in the players direction",
		"update": func (): base_ammo += 1,
	}
	
	levels = {
		'2': {
			"details": "The snow ball cooldown is reduced by 1 second",
			"update": func (): base_cooldown -= 1,
		}
	}


func get_targets(count):
	var result = []
	
	for _i in range(count):
		result.append(player.global_position + player.last_movement)

	return result
