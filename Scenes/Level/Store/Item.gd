class_name Item extends Node2D

signal level_updated
signal lock_updated

@export var icon        : CompressedTexture2D = null
@export var displayname : String              = "..."

@export var max_level : int = 0

@export var base_level = 0
var level : int = 0 :
	set(value):
		var config
		
		while level < value:
			if locked: break
			
			config = get_level_config(level)

			player.coins -= price
			config['update'].call()
			
			level += 1
			
			locked = level >= max_level || player.coins < price
			emit_signal("level_updated")

		

var price : int = 0 : 
	get: return get_price(level)

var default_level = {}
var levels        = {}


func get_price(_level): return 0

var locked = false :
	set(value):
		locked = value
		emit_signal("lock_updated")

@onready var player : Player = get_tree().get_first_node_in_group("player")

func _ready():
	level = base_level
	
	setup_stats()
	
	player.connect("stats_updated", setup_stats)
	

func get_level_config(value):
	if str(value) in levels: return levels[str(value)]
	if value < max_level   : return default_level
	
	return null

func setup_stats(): pass
