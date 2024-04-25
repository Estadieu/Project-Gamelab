extends Sprite2D

func _ready():
	texture = load("res://Textures/Map/Grass/" + str((randi() % 5) + 1) + ".png")
