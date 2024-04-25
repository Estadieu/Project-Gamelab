extends RigidBody2D

@onready var sprite = get_node("Sprite2D")

func _ready():
	#sprite.update(load("res://Textures/Map/Rock/" + str((randi() % 16) + 1) + ".png"))
	var image = Image.new()
	image.load("res://Textures/Map/Rock/" + str((randi() % 16) + 1) + ".png")
	
	sprite.texture = ImageTexture.create_from_image(image)
