extends Node

const WEAPON_PATH = "res://Textures/Items/Weapons/"

var javelin = preload("res://Player/Attack/javelin.tscn")

func init(_player, stats):
	stats['ammo'] = 0
	
	stats['hp'] = 9999
	stats['speed'] = 200.0
	stats['damage'] = 10
	stats['knockback_amount'] = 100
	stats['paths'] = 0
	stats['attack_size'] = 1.0
	stats['attack_speed'] = 5.0
		
func attack(player, stats):
	var javelinBase = player.get_node("%JavelinBase")
	
	var get_javelin_total = javelinBase.get_child_count()
	var calc_spawns = (stats['ammo'] + player.stats['additional_attacks']) - get_javelin_total
	
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

@onready var config = {
	"icon": WEAPON_PATH + "javelin_3_new_attack.png",
	"displayname": "Javelin",
	"type": "weapon",
	
	"default_level": {
		"max_level": 4,
		"details": "The javelin will now attack an additional enemy per attack",
		"update": func (_player, stats):
			stats['paths'] += 1,
	},
	
	"levels": {
		'0': {
			"details": "A magical javelin will follow you attacking enemies in a straight line",
			"update": func (_player, stats):
				stats['ammo'] += 1,
		},
		'3': {
			"max_level": 4,
			"details": "The javelin will now attack an additional enemy per attack",
			"update": func (_player, stats):
				stats['paths'] += 1
				stats['damage'] = 15
				stats['knockback_amount'] = 120,
		}
	}
}
