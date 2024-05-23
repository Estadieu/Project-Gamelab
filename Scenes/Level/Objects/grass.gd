extends Sprite2D

func _ready():
	texture = load("res://Textures/Level/Map/Grass/" + str((randi() % 5) + 1) + ".png")
