extends Node2D

@onready var background = get_node("Background")

@export var nb_rock  : int = 400
@export var nb_grass : int = 2000
@export var border_size : int = 65

var rock  = preload("res://Scenes/Level/Map/rock.tscn")
var grass = preload("res://Scenes/Level/Map/grass.tscn")
var water = preload("res://Scenes/Level/Map/water.tscn")  

func _ready():
	# Object on map
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
		
	# water on map
	add_water_border()

func add_water_border():
	var bg_size = background.region_rect.size
	var half_width = int(bg_size.x / 2)
	var half_height = int(bg_size.y / 2)
	
	# Ajouter de l'eau en haut et en bas
	for x in range(-half_width - border_size, half_width + border_size, 64):
		for y in [-half_height - border_size, half_height + border_size]:
			var new_water = water.instantiate()
			new_water.position = Vector2(x, y)
			add_child(new_water)
			
	# Ajouter de l'eau à gauche et à droite
	for y in range(-half_height - border_size, half_height + border_size, 64):
		for x in [-half_width - border_size, half_width + border_size]:
			var new_water = water.instantiate()
			new_water.position = Vector2(x, y)
			add_child(new_water)
