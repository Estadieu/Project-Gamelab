extends Item

func get_price(lvl): return 5 * lvl + 5

func _init():
	default_level = {
		"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
		"update": func (): player.spell_cooldown -= .05,
	}
