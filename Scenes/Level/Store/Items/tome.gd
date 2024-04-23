extends Item

func _init():
	default_level = {
		"price": 1,
		"details": "Increases the size of spells an additional 10% of their base size",
		"update": func (): player.add_stats('spell_size', 0.10),
	}
