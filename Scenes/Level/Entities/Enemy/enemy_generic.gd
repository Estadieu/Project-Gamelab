class_name Enemy extends Entity

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer
@onready var snd_hit = $snd_hit
@onready var hitBox = $HitBox

var death_anim = preload("res://Scenes/Level/Entities/Enemy/explosion.tscn")
var exp_gem = preload("res://Scenes/Level/Objects/experience_gem.tscn")

signal remove_from_array(object)

func _init():
	super._init()

func _ready():
	anim.play("walk")
	hitBox.stats['damage'] = _stats['damage']

func _physics_process(_delta):
	_stats['knockback'] = _stats['knockback'].move_toward(Vector2.ZERO, _stats['knockback_recovery'])

	var direction = global_position.direction_to(player.global_position)
	velocity = direction * _stats['speed']
	velocity += _stats['knockback']

	move_and_slide()
	
	if direction.x > 0.1:
		sprite.flip_h = true
	elif direction.x < -0.1:
		sprite.flip_h = false

func death():
	emit_signal("remove_from_array", self)

	var enemy_death = death_anim.instantiate()
	enemy_death.scale = sprite.scale
	enemy_death.global_position = global_position

	get_parent().call_deferred("add_child",enemy_death)

	var new_gem = exp_gem.instantiate()
	new_gem.global_position = global_position
	new_gem.experience = _stats['experience']
	loot_base.call_deferred("add_child",new_gem)

	queue_free()

func _on_hurt_box_hurt(damage, angle, knockback_amount):
	_stats['hp'] -= damage
	_stats['knockback'] = angle * knockback_amount

	if _stats['hp'] <= 0:
		death()

	else:
		snd_hit.play()
