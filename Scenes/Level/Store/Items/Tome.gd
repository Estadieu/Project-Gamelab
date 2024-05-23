extends Item

func get_price(lvl): return 10 * lvl + 10

func _init():
	default_level = {
		"details": "Increases the size of spells an additional 10% of their base size",
		"update": func (): player.spell_size += 0.1,
	}
