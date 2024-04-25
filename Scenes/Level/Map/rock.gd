extends RigidBody2D

@onready var sprite = get_node("Sprite2D")

func _ready():
	var image = Image.load_from_file("res://Textures/Map/Rock/" + str((randi() % 16) + 1) + ".png")
	var texture = ImageTexture.create_from_image(image)
	sprite.texture = texture
