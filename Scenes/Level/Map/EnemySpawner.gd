extends Node2D

@export var spawns : Array[SpawnInfo] = []

@onready var player     = get_tree().get_first_node_in_group("player")
@onready var background = get_parent().get_parent()

func _on_time_updated(time):
	for spawn in spawns:
		# If the spawn is active
		if time >= spawn.time_start and time <= spawn.time_end:
			# Setup spawn delay
			if spawn.spawn_delay_counter < spawn.enemy_spawn_delay:
				spawn.spawn_delay_counter += 1
			else:
				# If the delay is ended
				spawn.spawn_delay_counter = 0
				
				# Generate and spawn "spawn.enemy_num" enemies
				for _i in range(0, spawn.enemy_num):
					var new_enemy : Enemy = spawn.enemy.instantiate()
					new_enemy.global_position = get_random_position()

					get_parent().add_child(new_enemy)

func get_random_position():
	# Get randomly expanded viewport 
	var vpr = get_viewport_rect().size * randf_range(1.1,1.4)
	
	# Get corners
	var top_left     = Vector2(player.global_position.x - vpr.x/2, player.global_position.y - vpr.y/2)
	var top_right    = Vector2(player.global_position.x + vpr.x/2, player.global_position.y - vpr.y/2)
	var bottom_left  = Vector2(player.global_position.x - vpr.x/2, player.global_position.y + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y + vpr.y/2)

	var sides = []
	
	# Add possible borders
	if top_left   .y > - background.region_rect.size.y / 2: sides.append("up"   )
	if bottom_left.y < + background.region_rect.size.y / 2: sides.append("down" )
	if top_left   .x > - background.region_rect.size.x / 2: sides.append("left" )
	if top_right  .x < + background.region_rect.size.x / 2: sides.append("right")
	
	# Pick a random border
	var pos_side = sides.pick_random()

	# Compute choosed coordonate interval
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left

	# Pick random coordinate limited by map size (minus 128px)
	var x_spawn = max(min(randf_range(spawn_pos1.x, spawn_pos2.x), background.region_rect.size.x / 2 - 128), - background.region_rect.size.x / 2 + 128)
	var y_spawn = max(min(randf_range(spawn_pos1.y, spawn_pos2.y), background.region_rect.size.y / 2 - 128), - background.region_rect.size.y / 2 + 128)
	
	return Vector2(x_spawn, y_spawn)
