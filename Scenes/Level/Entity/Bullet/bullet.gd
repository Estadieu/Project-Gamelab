class_name Bullet extends Entity

var shoted = false

var target = null :
	set(value):
		target = value
		
		if target != null:
			direction = global_position.direction_to(target.global_position)
			 
var direction = null

@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	super._ready()
	
	if target != null:
		global_position = player.global_position
		target = target
	
	global_position = player.global_position + direction.normalized() * 32
	
	rotation = direction.angle() + deg_to_rad(135)
	scale = Vector2(0, 0)
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1) * player.spell_size, 0.25)
	tween.tween_callback(func(): shoted = true)
	tween.play()


func _on_hurted_by_objects(_node : Node2D):
	hp = 0

func get_direction():
	return Vector2.ZERO if not shoted else direction

func set_animation(_dir):
	rotation = direction.angle() + deg_to_rad(135)
