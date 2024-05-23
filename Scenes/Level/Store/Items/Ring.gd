extends Item

func get_price(lvl): return 50 * lvl + 50

func _init():
	default_level = {
		"details": "Your spells now spawn 1 more additional attack",
		"update": func (): player.spell_additionnal += 1,
	}
