class_name Enemy extends Entity

@export var damage     : float = 1.0
@export var experience : int   = 1

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")

@onready var hitBox = $HitBox

var death_anim = preload("res://Scenes/Level/Entities/Enemy/explosion.tscn")
var exp_gem = preload("res://Scenes/Level/Objects/experience_gem.tscn")

signal remove_from_array(object)

func _init():
	super._init()

func _ready():
	super._ready()

	hitBox.stats['damage'] = damage

func get_direction():
	return global_position.direction_to(player.global_position)

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
