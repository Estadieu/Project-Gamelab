extends RigidBody2D

@onready var sprite = get_node("Sprite2D")

func _ready():
	sprite.texture = load("res://Textures/Map/Rock/" + str((randi() % 16) + 1) + ".png")
