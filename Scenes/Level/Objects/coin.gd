extends Area2D

@export var value = 1

var bronze = preload("res://Textures/Level/Coins/bronze.png")
var silver = preload("res://Textures/Level/Coins/silver.png")
var gold   = preload("res://Textures/Level/Coins/gold.png"  )
var black   = preload("res://Textures/Level/Coins/black.png"  )

var target = null
var speed = 1

@onready var sprite = $Sprite2D

func _ready():
	# Check for the black coin
	if value == -20:
		sprite.texture = black
		return

	# Default bronze
	if value < 15:
		sprite.texture = bronze
		return

	# Silver or gold
	if value < 50:
		sprite.texture = silver
	else:
		sprite.texture = gold
	
func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2 * delta

func collect():
	$SndCollected.play()
	$CollisionShape2D.call_deferred("set", "disabled", true)
	sprite.visible = false
	
	return value

func _on_snd_collected_finished():
	queue_free()
