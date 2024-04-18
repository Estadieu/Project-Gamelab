extends Area2D

class_name Bullet

var stats = null
var current_hp = null

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
signal remove_from_array(object)

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(135)
	
	current_hp = stats['base_hp']

	var tween = create_tween()
	tween \
		.tween_property(self, "scale", Vector2(1,1) * stats['attack_size'], 1) \
		.set_trans(Tween.TRANS_QUINT) \
		.set_ease(Tween.EASE_OUT)
	tween.play()

func _physics_process(delta):
	position += angle * delta * stats['speed']

func enemy_hit(charge = 1):
	current_hp -= charge
	
	if current_hp <= 0:
		remove()


func remove():
	emit_signal("remove_from_array", self)
	queue_free()
