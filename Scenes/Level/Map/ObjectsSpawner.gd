extends Node2D

# Get reference to the grandparent node (background)
@onready var background = get_parent().get_parent()

# Exported variables to set the number of rocks and grass instances (random)
@export var nb_rock  : int = 350
@export var nb_grass : int = 2000

# List of preloaded rock scenes
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

# Preload the grass scene
var grass = preload("res://Scenes/Level/Objects/grass.tscn")

# Function called when the node is added to the scene and add rocks randomly
func _ready():
	# Add rocks to the scene
	for i in range(nb_rock):
		# Create a new instance of a rock
		var new_rock = rocks[randi() % rocks.size()].instantiate()
		# Set a random position within the background's region
		new_rock.position = Vector2(
			(randi() % int(background.region_rect.size.x)) - int(background.region_rect.size.x / 2), 
			(randi() % int(background.region_rect.size.y)) - int(background.region_rect.size.y / 2)
		)
		# Defer adding the new rock to the parent node
		get_parent().call_deferred("add_child", new_rock)
	
	# Add grass to the scene (randomly)
	for i in range(nb_grass):
		# Create a new instance of grass
		var new_grass = grass.instantiate()
		# Set a random position within the background's region
		new_grass.position = Vector2(
			(randi() % int(background.region_rect.size.x)) - int(background.region_rect.size.x / 2), 
			(randi() % int(background.region_rect.size.y)) - int(background.region_rect.size.y / 2)
		)
		# Add the new grass to the current node
		add_child(new_grass)
