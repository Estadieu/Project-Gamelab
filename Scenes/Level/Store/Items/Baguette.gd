extends Weapon

@export var paths : int = 1

var remaining_paths : int

func get_price(lvl): return 20 * lvl + 20

func _init():
	default_level = {
		"price": 5,
		"details": "The javelin will now attack an additional enemy per attack",
		"update": func (): paths += 1,
	}
	
	levels = {
		'0': {
			"price": 5,
			"details": "A magical javelin will follow you attacking enemies in a straight line",
			"update": func (): base_ammo += 1,
		},
		'3': {
			"price": 20,
			"details": "The javelin will now attack an additional enemy per attack",
			"update": func ():
				paths += 1
				base_stats['damage'] = 15,
		}
	}

func _on_burst_end():
	remaining_paths = paths - 1
	
	$PathTimer.start()
	
func _on_path_end():
	var baguettes = get_tree().get_nodes_in_group("baguette")

	if remaining_paths == 0:
		for baguette in baguettes:
			baguette.queue_free()
			
		$PathTimer.stop()
		super._on_burst_end()
		return

	remaining_paths -= 1

	var targets = player.get_targets()

	for baguette in baguettes:
		baguette.target = targets.pick_random()
		
	$PathTimer.start()

func get_targets(count):
	var targets = player.get_targets()
	targets.shuffle()
	
	return targets
