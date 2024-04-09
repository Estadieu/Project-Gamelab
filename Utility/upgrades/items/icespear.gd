extends Node

const WEAPON_PATH = "res://Textures/Items/Weapons/"

var iceSpear = preload("res://Player/Attack/bullet/ice_spear.tscn")

func init(_player, stats):
	stats['bullet'] = preload("res://Player/Attack/bullet/ice_spear.tscn")

	stats['burst_cooldown'] = 1.5
	
	stats['hp'] = 1
	stats['speed'] = 100
	stats['damage'] = 5
	stats['knockback_amount'] = 100
	stats['attack_size'] = 1.0


func get_target(_player, _stats):
	pass

@onready var config = {
	"icon": WEAPON_PATH + "ice_spear.png",
	"displayname": "Ice Spear",
	"type": "gun",

	"default_level": {
		"max_level": 4,
		"details": "A spear of ice is thrown at a random enemy",
		"update": func (_player, stats):
			stats['baseammo'] += 1,
	},

	"levels": {
		'2': {
			"details": "Ice Spears now pass through another enemy and do + 3 damage",
			"update": func (_player, stats):
				stats['hp']      = 2
				stats['damage'] += 3,
		},
		'3': {
			"details": "An additional 2 Ice Spears are thrown",
			"update": func (_player, stats):
				stats['baseammo'] += 2,
		}
	}
}
