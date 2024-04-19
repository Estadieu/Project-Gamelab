class_name Enemy extends Entity

@export var damage     : float = 1.0
@export var experience : int   = 1

var knockback : Vector2 = Vector2.ZERO
@export var knockback_recovery : float = 3.5

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
	hitBox.stats['damage'] = damage

func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)

	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	velocity += knockback

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
	new_gem.experience = experience
	loot_base.call_deferred("add_child",new_gem)

	queue_free()

func _on_hurt_box_hurt(p_damage, angle, knockback_amount):
	print("hurted")
	hp -= p_damage
	knockback = angle * knockback_amount

	if hp <= 0:
		death()

	else:
		snd_hit.play()
