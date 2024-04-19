extends Item

func _init():
	super._init("res://Textures/Items/Upgrades/thick_new.png", "Tome")

	default_level = {
		"max_level": 5,
		"price": 1,
		"details": "Increases the size of spells an additional 10% of their base size",
		"update": func (): player.add_stats('spell_size', 0.10),
	}
