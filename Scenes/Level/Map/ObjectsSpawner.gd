extends Node2D

@onready var background = get_parent().get_parent()

@export var nb_rock  : int = 350
@export var nb_grass : int = 2000

var rocks = [
	preload("res://Scenes/Level/Objects/Rock/rock_1.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_2.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_3.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_4.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_5.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_6.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_7.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_8.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_9.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_10.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_11.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_12.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_13.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_14.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_15.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_16.tscn")
]
var grass = preload("res://Scenes/Level/Objects/grass.tscn")

func _ready():
	# Rocks
	for i in range(nb_rock):
		var new_rock = rocks[randi() % rocks.size()].instantiate()
		new_rock.position = Vector2(
			(randi() % int(background.region_rect.size.x)) - int(background.region_rect.size.x / 2), 
			(randi() % int(background.region_rect.size.y)) - int(background.region_rect.size.y / 2)
		)
		get_parent().call_deferred("add_child", new_rock)
	
	# Grass
	for i in range(nb_grass):
		var new_grass = grass.instantiate()
		new_grass.position = Vector2(
			(randi() % int(background.region_rect.size.x)) - int(background.region_rect.size.x / 2), 
			(randi() % int(background.region_rect.size.y)) - int(background.region_rect.size.y / 2)
		)
		add_child(new_grass)
