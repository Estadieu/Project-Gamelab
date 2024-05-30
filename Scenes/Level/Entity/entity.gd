class_name Entity extends CharacterBody2D

#Signal emitted when the entity dies
signal die()

#Exported variables for change in the editor 
@export var speed  : float = 32.0
@export var damage : float = 0.0
@export var armor  : int   = 0

#Group name for enemies
@export var enemy_group : String = ""

#Variable to store the last movement direction
var last_movement : Vector2

#Knockback effect
var knockback : Vector2 = Vector2.ZERO
#Constants
const knockback_recovery : float = 1
const knockback_amount   : float = 64

#Define max health points 
@export var max_hp : int = 10 :
	set(value):
		max_hp = value
		
		if healthBar != null:
			healthBar.max_value = value

#Current health points
var hp : int :
	set(value):
		hp = value
		healthBar.value = value
		
		if hp <= 0: death()

#On-ready variables for node references
@onready var animationPlayer = $AnimationPlayer
@onready var sprite          = $Sprite2D
@onready var healthBar       = $HealthBar
@onready var hurtBox         = $HurtBox/CollisionShape2D
@onready var hurtBoxTimer    = $HurtBox/DisableTimer

#Function to get movement direction
func get_direction(): return null
#Function to set animation based on direction
func set_animation(_direction): pass

#Called when the node is added to the scene
func _ready():
	max_hp = max_hp
	hp     = max_hp

#Physics frame
func _physics_process(_delta):
	#Get normalized direction of movement
	var direction = get_direction().normalized()
	
	#If there's movement, update last_movement
	if direction != Vector2.ZERO:
		last_movement = direction
	
	#Update animation based on direction
	set_animation(direction)

	#Reduce knockback
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	#Calculate velocity with knockback and movement
	velocity = direction * speed + knockback

	#Move the character
	move_and_slide()


# -- HurtBox --

#Function that is call when the entity is hurt
func _on_hurted(area):
	#Get the entity that caused the hurt
	var entity : Node2D = area.get_parent()

	#if entity is in the enemy group
	if entity.is_in_group(enemy_group):
		#calculate damage based on the armor
		var taken_damage = max(entity.damage - armor, 0)
		
		#reduce health by the damage taken
		hp -= taken_damage
		#apply knockback based on the direction from the entity
		knockback = entity.global_position.direction_to(global_position).normalized() * knockback_amount
		
		
		_on_taking_damage(taken_damage)
		
		# Disable the hurt box temporarily
		hurtBox.call_deferred("set", "disabled", true)
		# Start the hurt box timer
		hurtBoxTimer.start()

# Custom function for additional actions on taking damage (to be overridden)
#is to make sure that the entity do not get damage in this period of time
func _on_taking_damage(_taken_damage): pass

#when the hut box disable timer times out
func _on_disable_hurt_box_timeout():
	#Re enable the hurt box
	hurtBox.call_deferred("set", "disabled", false)


#when the entity dies
func death():
	#emit the signal
	emit_signal("die")
	#queue the entity to be remove
	call_deferred("queue_free")
