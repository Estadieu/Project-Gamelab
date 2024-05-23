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

	
func set_target(new_bullet):
	new_bullet.direction = player.last_movement
