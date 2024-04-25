extends Node2D

@onready var background = get_node("Background")

@export var nb_rock  : int = 500
@export var nb_grass : int = 2000

var rock  = preload("res://Scenes/Level/Map/rock.tscn")
var grass = preload("res://Scenes/Level/Map/grass.tscn")

func _ready():
	for i in range(nb_rock):
		var new_rock = rock.instantiate()
		new_rock.position = Vector2(
			(randi() % int(background.region_rect.size.x)) - int(background.region_rect.size.x / 2), 
			(randi() % int(background.region_rect.size.y)) - int(background.region_rect.size.y / 2)
		)
		
		add_child(new_rock)
		
	for i in range(nb_grass):
		var new_grass = grass.instantiate()
		new_grass.position = Vector2(
			(randi() % int(background.region_rect.size.x)) - int(background.region_rect.size.x / 2), 
			(randi() % int(background.region_rect.size.y)) - int(background.region_rect.size.y / 2)
		)
		
		add_child(new_grass)
