extends Entity

@onready var detectionArea = get_node("Areas/EnemyDetectionArea")

var _stats = {
	'spell_cooldown': 0,
	'speed_speed'   : 0,
	'spell_size'    : 0,

	'additional_attacks': 0
}

var coins = 0 :
	set(value):
		var old_value = coins
		
		coins = value
		
		emit_signal("coins_updated", old_value, coins)

#Signal
signal coins_updated(     old_value, value)
signal stats_updated(key, old_value, value)

signal player_death

func get_direction():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	return Vector2(x_mov, y_mov)

func set_stats(key, value):
	if _stats[key] != value:
		var old_value = _stats[key]

		_stats[key] = value

		emit_signal("stats_updated", key, old_value, value)

func add_stats(key, value): set_stats(key, _stats[key] + value)
	
func get_stats(key):
	return _stats[key]

func get_random_target():
	var enemy_close = detectionArea.get_overlapping_bodies()
	
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP

func _on_grab_area_area_entered(area):
	area.target = self

func _on_collect_area_area_entered(area):
	coins += area.collect()

func death():
	emit_signal("player_death")
