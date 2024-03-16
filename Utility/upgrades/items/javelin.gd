extends Node

const WEAPON_PATH = "res://Textures/Items/Weapons/"

var javelin = preload("res://Player/Attack/javelin.tscn")

@onready var config = {
	"icon": WEAPON_PATH + "javelin_3_new_attack.png",
	"displayname": "Javelin",
	"type": "weapon",
	
	"init": func (_player, stats):
		stats['ammo'] = 0,
		
	"attack": func (player, stats):		
		var javelinBase = player.get_node("%JavelinBase")
		
		var get_javelin_total = javelinBase.get_child_count()
		var calc_spawns = (stats['ammo'] + player.stats['additional_attacks']) - get_javelin_total
		
		while calc_spawns > 0:
			var javelin_spawn = javelin.instantiate()
			javelin_spawn.global_position = player.global_position
			javelinBase.add_child(javelin_spawn)
			calc_spawns -= 1
		#Upgrade Javelin
		var get_javelins = javelinBase.get_children()
		for i in get_javelins:
			if i.has_method("update_javelin"):
				i.update_javelin(),
	
	"levels": [
		{
			"details": "A magical javelin will follow you attacking enemies in a straight line",
			"update": func (_player, stats):
				stats['ammo'] += 1,
		},
		{
			"details": "The javelin will now attack an additional enemy per attack",
			"update": func (_player, _stats):
				pass,
		},
		{
			"details": "The javelin will attack another additional enemy per attack",
			"update": func (_player, _stats):
				pass,
		},
		{
			"details": "The javelin now does + 5 damage per attack and causes 20% additional knockback",
			"update": func (_player, _stats):
				pass,
		}
	]
}
