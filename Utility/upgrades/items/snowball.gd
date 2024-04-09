extends Node

const WEAPON_PATH = "res://Textures/Items/Weapons/"

var snowball  = preload("res://Player/Attack/bullet/snowball.tscn")

func init(_player, stats):
	stats['bullet'] = snowball
	
	stats['burst_cooldown'] = 3
	
	stats['hp'] = 9999
	stats['speed'] = 100.0
	stats['damage'] = 5
	stats['knockback_amount'] = 100
	stats['attack_size'] = 0.5
		
func get_target(_player, _stats):
	pass

@onready var config = {
	"icon": WEAPON_PATH + "snowball.png",
	"displayname": "Snow ball",
	"type": "gun",
	
	"default_level": {
		"max_level": 5,
		"details": "A snowball is created and random heads somewhere in the players direction",
		"update": func (_player, stats):
			stats['baseammo'] += 1,
	},
	
	"levels": {
		'2': {
			"details": "The snow ball cooldown is reduced by 0.5 seconds",
			"update": func (_player, stats):
				stats['burst_cooldown'] += 1,
		},
		'4': {
			"details": "A snowball is created and random heads somewhere in the players direction",
			"update": func (_player, stats):
				stats['baseammo'] += 1
				stats['knockback_amount'] = 125,
		}
	}
}
