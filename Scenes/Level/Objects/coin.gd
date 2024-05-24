extends Area2D

@export var value = 1

var bronze = preload("res://Textures/Level/Coins/bronze.png")
var silver = preload("res://Textures/Level/Coins/silver.png")
var gold   = preload("res://Textures/Level/Coins/gold.png"  )

var target = null
var speed = 1

@onready var sprite = $Sprite2D

func _ready():
	# Default bronze
	if value < 20: return

	# Else (silver or gold)
	sprite.texture = silver if value < 50 else gold
	
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
