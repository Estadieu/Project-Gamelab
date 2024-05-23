extends Item

func get_price(lvl): return 5 * lvl + 5

func _init():
	default_level = {
		"details": "Reduces Damage By 1 point",
		"update": func (): player.armor += 1,
	}
