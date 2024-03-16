extends Node

const WEAPON_PATH = "res://Textures/Items/Weapons/"

var tornado  = preload("res://Player/Attack/tornado.tscn")

@onready var config = {
	"icon": WEAPON_PATH + "tornado.png",
	"displayname": "Tornado",
	"type": "gun",
	
	"init": func (player, stats):
		stats['attackspeed'] = 3
		stats['bullet'] = tornado,
		
	"attack": func (player, stats):
		pass,
	
	"levels": [
		{
			"details": "A tornado is created and random heads somewhere in the players direction",
			"update": func (_player, stats):
				stats['baseammo'] += 1,
		},
		{
			"details": "An additional Tornado is created",
			"update": func (_player, stats):
				stats['baseammo'] += 1,
		},
		{
			"details": "The Tornado cooldown is reduced by 0.5 seconds",
			"update": func (_player, stats):
				stats['attackspeed'] += 1,
		},
		{
			"details": "An additional tornado is created and the knockback is increased by 25%",
			"update": func (_player, stats):
				stats['baseammo'] += 1,
		}
	]
}
