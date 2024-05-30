class_name Player extends Entity 

signal coins_updated(value) #Signal when the number of coins is UPT
signal stats_updated() #When the player's stats are updated

#Allows you to change the player's state (its different statistics)
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
	coins = coins # Initialize the coins.
	super._ready()  # Call the _ready function of the parent class.

func get_direction():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left") #Calculate hori movement
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up") #Calculate verti movement
	
	return Vector2(x_mov, y_mov)  # Return the movement vector.
	
func set_animation(direction):
	animationPlayer.play("idle" if direction == Vector2.ZERO else "walk")  # Play idle or walk animation based on direction.
	sprite.flip_h = (direction.x == 0 && sprite.flip_h) || (direction.x < 0) # Flip sprite horizontally based on movement direction.

func _on_grabed(area):
	area.target = self  # Set the target of the grabbed area to self.

func _on_collected(area):
	var collected = area.collect()  # Collect items
	
	coins += collected
	
	var x = (randi() % 8) - 4
	
	# Instantiate a new label.
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
	return $DetectionBox.get_overlapping_bodies() # Get bodies overlapping with the detection box.

func get_random_target():
	var enemy_close = $DetectionBox.get_overlapping_bodies()  # Get bodies overlapping with the detection box.

	return enemy_close.pick_random() if enemy_close.size() > 0 else null # Return a random target if available.

func _on_taking_damage(taken_damage):
	var x = 24 + (randi() % 8) - 4 # Randomize x position.
	
	var new_label = label.instantiate()
	new_label.text = str("-", taken_damage)  # Set the label text.
	new_label.position = Vector2(x, 24) # Set the label position
	new_label.modulate = Color(255, 0, 0, 1.0)
	
	$LabelsLayer.add_child(new_label)
	
	var tween = create_tween()
	tween.tween_property(new_label, "position", Vector2(x, 8), .5)  # Animate the label position.
	tween.tween_property(new_label, "modulate", Color(255, 0, 0, 0.0), .5)
	tween.tween_callback(func(): new_label.queue_free())  # Queue the label for deletion after animation.
	tween.play()

# Emit the die signal
func death():
	emit_signal("die")
