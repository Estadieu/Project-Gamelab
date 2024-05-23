class_name Player extends Entity

signal coins_updated(value)
signal stats_updated()

@export var spell_additionnal : int   = 0 :
	set(value):
		spell_additionnal = value
		emit_signal("stats_updated")
		
@export var spell_size : float = 1 :
	set(value):
		spell_size = value
		emit_signal("stats_updated")

@export var spell_cooldown : float = 1 :
	set(value):
		spell_cooldown = value
		emit_signal("stats_updated")


@export var coins : int = 0 :
	set(value):
		coins = value
		emit_signal("coins_updated", value)

var label = preload("res://Scenes/Level/Entity/Player/label.tscn" )

func _ready():
	coins = coins
	super._ready()

func get_direction():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	return Vector2(x_mov, y_mov)
	
func set_animation(direction):
	$AnimationPlayer.play("idle" if direction == Vector2.ZERO else "walk")
	$Sprite2D.flip_h = (direction.x == 0 && $Sprite2D.flip_h) || (direction.x < 0)

func _on_grabed(area):
	area.target = self

func _on_collected(area):
	var collected = area.collect()
	
	coins += collected
	
	var x = (randi() % 8) - 4
	
	var new_label : Label = label.instantiate()
	new_label.text = str("+", collected)
	new_label.position = Vector2(x, 24)
	new_label.modulate = Color(0, 0, 255, 1.0)
	
	$LabelsLayer.add_child(new_label)
	
	var tween = create_tween()
	tween.tween_property(new_label, "position", Vector2(x, 8), .5)
	tween.tween_property(new_label, "modulate", Color(0, 0, 255, 0.0), .5)
	tween.tween_callback(func(): new_label.queue_free())
	tween.play()

func get_targets():
	return $DetectionBox.get_overlapping_bodies()

func get_random_target():
	var enemy_close = $DetectionBox.get_overlapping_bodies()

	return enemy_close.pick_random() if enemy_close.size() > 0 else null

func _on_taking_damage(taken_damage):
	var x = 24 + (randi() % 8) - 4
	
	var new_label = label.instantiate()
	new_label.text = str("-", taken_damage)
	new_label.position = Vector2(x, 24)
	new_label.modulate = Color(255, 0, 0, 1.0)
	
	$LabelsLayer.add_child(new_label)
	
	var tween = create_tween()
	tween.tween_property(new_label, "position", Vector2(x, 8), .5)
	tween.tween_property(new_label, "modulate", Color(255, 0, 0, 0.0), .5)
	tween.tween_callback(func(): new_label.queue_free())
	tween.play()


func death():
	emit_signal("die")
