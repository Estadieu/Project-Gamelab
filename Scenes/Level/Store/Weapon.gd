class_name Weapon extends Item

@export var bullet        : PackedScene = null
@export var map           : Node2D = null

@export var base_ammo : int = 0

@export var base_cooldown : float = 1 :
	set(value):
		base_cooldown = value
		setup_stats()

@export var base_stats    : Dictionary  = {}

var cooldown : float :
	get: return max(base_cooldown * player.spell_cooldown, 0.1)

var ammo : int

var current_bullet = 0
var targets = []

func setup_stats():
	if player != null:
		$BurstTimer.wait_time = cooldown

func generate(target):	
	var new_bullet = bullet.instantiate()

	# Stats
	for key in base_stats:
		new_bullet[key] = base_stats[key]

	new_bullet.scale *= player.spell_size
	new_bullet.target = target

	return new_bullet

func _on_burst_start():
	$BurstTimer.stop()
	
	ammo = base_ammo + (player.spell_additionnal if level > 0 else 0)
	
	current_bullet = 0
	targets = get_targets(ammo)
	
	_on_shot_start()

func _on_burst_end():
	$ShotTimer.stop()
	$BurstTimer.start()

func _on_shot_start():
	# Pass dead enemies
	while current_bullet < targets.size() && targets[current_bullet] == null:
		current_bullet += 1
	
	if ammo > 0 && current_bullet < targets.size():
		ammo -= 1
		
		var new_bullet = generate(targets[current_bullet])
	
		if new_bullet != null:
			map.add_child(new_bullet)
			
		current_bullet += 1
		
	if ammo > 0 && current_bullet < targets.size():
		$ShotTimer.start()
	else:
		_on_burst_end()

func get_targets(_count): return []
