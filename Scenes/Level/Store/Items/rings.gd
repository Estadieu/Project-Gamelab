extends Item

func _init():
	default_level = {
		"price": 10,
		"details": "Your spells now spawn 1 more additional attack",
		"update": func (): player.add_stats('additional_attacks', 1),
	}
