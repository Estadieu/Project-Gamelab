class_name Bullet extends Entity  # Extend entity.

var shoted = false  # Variable to track if the bullet has been shot.

# Variable for the target of the bullet.
var target = null :
	set(value):
		target = value
		
		# If the target is not null, calculate the direction towards the target.
		if target != null:
			if target is Entity:
				# Calculate direction to the target entity.
				direction = global_position.direction_to(target.global_position)
			elif target is Vector2:
				# Calculate direction to the target position.
				direction = global_position.direction_to(target)
			 
var direction = null  #Store the direction of the bullet.

@onready var player = get_tree().get_first_node_in_group("player")  #First node in the group "player" when the scene is ready.

func _ready():
	super._ready()  # Calls the _ready function
	
	if target != null:
		# Set the global position to the player's position and set the target.
		global_position = player.global_position
		target = target
	
	# Calculate initial position based on direction and player position.
	global_position = player.global_position + direction.normalized() * 32
	
	# Set the rotation based on the direction and adjust with an angle.
	rotation = direction.angle() + deg_to_rad(135)
	
	# Initialize scale to zero.
	scale = Vector2(0, 0)
	
	# Create a tween animation to scale the bullet.
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1) * player.spell_size, 0.25)  # Scale the bullet over 0.25 seconds.
	tween.tween_callback(func(): shoted = true)  # Set shoted to true after the tween is done.
	tween.play()  # Play the tween animation.

# When the bullet is hurt by objects.
func _on_hurted_by_objects(_node : Node2D):
	hp = 0  # Set the bullet's hp to 0.

# Function to get the direction of the bullet.
func get_direction():
	return Vector2.ZERO if not shoted else direction  # Return zero vector if not shot, else return direction.

# Set the animation based on direction.
func set_animation(_dir):
	rotation = direction.angle() + deg_to_rad(135)  # Update rotation based on direction.

