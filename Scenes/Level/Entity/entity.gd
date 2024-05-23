class_name Entity extends CharacterBody2D

signal die()

@export var speed  : float = 32.0
@export var damage : float = 0.0
@export var armor  : int   = 0

@export var enemy_group : String = ""

var last_movement : Vector2

var knockback : Vector2 = Vector2.ZERO
const knockback_recovery : float = 1
const knockback_amount   : float = 64

@export var max_hp : int = 10 :
	set(value):
		max_hp = value
		$HealthBar.max_value = value

var hp : int :
	set(value):
		hp = value
		$HealthBar.value = value
		
		if hp <= 0: death()

func get_direction(): return null
func set_animation(_direction): pass

func _ready():
	max_hp = max_hp
	hp     = max_hp

func _physics_process(_delta):
	var direction = get_direction().normalized()
	
	if direction != Vector2.ZERO:
		last_movement = direction
		
	set_animation(direction)

	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	velocity = direction * speed + knockback

	move_and_slide()


# -- HurtBox --

func _on_hurted(area):
	var entity : Node2D = area.get_parent()

	if entity.is_in_group(enemy_group):
		var taken_damage = max(entity.damage - armor, 0)
		
		hp -= taken_damage
		knockback = entity.global_position.direction_to(global_position).normalized() * knockback_amount
		
		_on_taking_damage(taken_damage)
		
		$HurtBox/CollisionShape2D.call_deferred("set", "disabled", true)
		$HurtBox/DisableTimer.start()

func _on_taking_damage(_taken_damage): pass

func _on_disable_hurt_box_timeout():
	$HurtBox/CollisionShape2D.call_deferred("set", "disabled", false)


func death():
	emit_signal("die")
	call_deferred("queue_free")
