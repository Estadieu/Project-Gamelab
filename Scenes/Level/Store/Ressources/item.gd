class_name Item extends Node2D

@export var icon        : CompressedTexture2D = null
@export var displayname : String              = "..."

@export var max_level : int = 0

var level = 0 :
	set(value):
		level = value
		emit_signal("updated")

var default_level = {}
var levels        = {}

var player = null :
	set(value):
		player = value
		_connected()
	
var locked = true

signal updated

func _connected():
	pass

func get_level_config(value):
	var config = null

	if str(value) in levels:
		config = levels[str(value)]

	elif default_level != null and value < max_level:
		config = default_level

	return config

func upgrade():
	var config = get_level_config(level)

	if not locked and config != null:
		level += 1
		
		config['update'].call()
		
		player.coins -= config.price
