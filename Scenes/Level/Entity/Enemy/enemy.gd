class_name Enemy extends Entity

# Initializations
@export var gain : int = 1

@onready var player = get_tree().get_first_node_in_group("player")
@onready var map    = get_tree().get_first_node_in_group("map")

var death_animation = preload("res://Scenes/Level/Entity/Enemy/explosion.tscn")
var coin            = preload("res://Scenes/Level/Objects/coin.tscn")

# Compute enemy direction
func get_direction():
	return global_position.direction_to(player.global_position) # Direction to the player

func _on_taking_damage(_damage):
	healthBar.visible = true # Set health bar visible for hitted enemies

func randomize_gain():
	# Evil coins generations
	if randi() % 50 == 0:
		return -20
	return gain

func death():
	# Run explosion anmiation
	var enemy_death = death_animation.instantiate()
	enemy_death.scale = sprite.scale
	enemy_death.global_position = global_position

	get_parent().call_deferred("add_child", enemy_death)
	
	# Effective coins generation
	gain = randomize_gain()
	var new_coin = coin.instantiate()
	new_coin.global_position = global_position
	new_coin.value = gain
	map.call_deferred("add_child", new_coin)

	super.death()

func set_animation(direction):
	# Run walking animation
	animationPlayer.play("walk")
	sprite.flip_h = (direction.x == 0 && sprite.flip_h) || (direction.x < 0)
