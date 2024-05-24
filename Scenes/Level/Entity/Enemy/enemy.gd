class_name Enemy extends Entity

@export var gain : int = 1

@onready var player = get_tree().get_first_node_in_group("player")
@onready var map    = get_tree().get_first_node_in_group("map")

var death_animation = preload("res://Scenes/Level/Entity/Enemy/explosion.tscn")
var coin            = preload("res://Scenes/Level/Objects/coin.tscn")

func get_direction():	
	return global_position.direction_to(player.global_position)

func _on_taking_damage(_damage):
	$HealthBar.visible = true

func death():
	var enemy_death = death_animation.instantiate()
	enemy_death.scale = $Sprite2D.scale
	enemy_death.global_position = global_position

	get_parent().call_deferred("add_child", enemy_death)

	var new_coin = coin.instantiate()
	new_coin.global_position = global_position
	new_coin.value = gain
	map.call_deferred("add_child", new_coin)

	super.death()

	
func set_animation(direction):
	$AnimationPlayer.play("walk")
	$Sprite2D.flip_h = (direction.x == 0 && $Sprite2D.flip_h) || (direction.x < 0)
