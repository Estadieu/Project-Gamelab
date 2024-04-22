extends CharacterBody2D

class_name Entity

@export var max_hp : int   = 10
@export var armor  : int   =  0
@export var speed  : float = 20.0

var knockback : Vector2 = Vector2.ZERO
@export var knockback_recovery : float = 3.5

var last_movement = Vector2.ZERO

@onready var hp = max_hp

@onready var sprite = $Sprite2D
@onready var snd_hit = $snd_hit
@onready var anim = $AnimationPlayer
@onready var healthBar = get_node("HealthBar")

func _init():
	pass

func _ready():
	anim.play("walk")
	
	healthBar.max_value = max_hp

func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	
	var direction = get_direction().normalized()
	
	if direction == Vector2.ZERO:
		anim.stop(true)
	else:
		anim.play("walk")
		
		last_movement = direction

	velocity = direction * speed + knockback

	sprite.flip_h = (direction.x == 0 && sprite.flip_h) || (direction.x > 0)

	move_and_slide()
	

func _on_hurt_box_hurt(p_damage, angle, knockback_amount):
	hp -= clamp(p_damage - armor, 0.0, 999.0)
	knockback = angle * knockback_amount

	healthBar.value = hp

	if hp <= 0:
		death()

	else:
		snd_hit.play()

func get_direction():
	pass

func death():
	pass
