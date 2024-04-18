extends Item

var javelin = preload("res://Scenes/Level/Player/Attack/javelin.tscn")
	
func _init():
	super._init("res://Textures/Items/Weapons/javelin_3_new_attack.png", "Javelin")
	
	default_level = {
		"max_level": 4,
		"price": 1,
		"details": "The javelin will now attack an additional enemy per attack",
		"update": func (): stats['paths'] += 1,
	}
	
	levels = {
		'0': {
			"price": 1,
			"details": "A magical javelin will follow you attacking enemies in a straight line",
			"update": func (): stats['base_ammo'] += 1,
		},
		'3': {
			"price": 1,
			"details": "The javelin will now attack an additional enemy per attack",
			"update": func ():
				stats['paths'] += 1
				stats['damage'] = 15
				stats['knockback_amount'] = 120,
		}
	}
	
	stats = {
		'base_ammo': 0,
		'base_hp': 9999,
		
		'speed': 200.0,
		'damage': 10,
		'knockback_amount': 100,
		'paths': 1,
		'attack_size': 1.0,
		'attack_speed': 5.0
	}
		
func attack():
	var javelinBase = player.get_node("%JavelinBase")
	
	var get_javelin_total = javelinBase.get_child_count()
	var calc_spawns = (stats['base_ammo'] + player.stats['additional_attacks']) - get_javelin_total
	
	while calc_spawns > 0:
		var javelin_spawn = javelin.instantiate()
		javelin_spawn.global_position = player.global_position
		javelin_spawn.player = player
		javelin_spawn.stats = stats
		javelinBase.add_child(javelin_spawn)
		calc_spawns -= 1
		
	#Upgrade Javelin
	var get_javelins = javelinBase.get_children()
	for i in get_javelins:
		if i.has_method("update_javelin"):
			i.update_javelin()
