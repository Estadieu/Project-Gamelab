extends Node

const WEAPON_PATH = "res://Textures/Items/Weapons/"

var snowball  = preload("res://Player/Attack/snowball.tscn")

@onready var config = {
	"icon": WEAPON_PATH + "snowball.png",
	"displayname": "Snow ball",
	"type": "gun",
	
	"init": func (_player, stats):
		stats['attackspeed'] = 3
		stats['bullet'] = snowball,
		
	"attack": func (_player, _stats):
		pass,
	
	"levels": [
		{
			"details": "A snowball is created and random heads somewhere in the players direction",
			"update": func (_player, stats):
				stats['baseammo'] += 1,
		},
		{
			"details": "An additional snow ball is created",
			"update": func (_player, stats):
				stats['baseammo'] += 1,
		},
		{
			"details": "The snow ball cooldown is reduced by 0.5 seconds",
			"update": func (_player, stats):
				stats['attackspeed'] += 1,
		},
		{
			"details": "An additional snow ball is created and the knockback is increased by 25%",
			"update": func (_player, stats):
				stats['baseammo'] += 1,
		}
	]
}
