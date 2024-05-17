extends Control

var level = "res://Scenes/Level/level.tscn"

# Variables pour contrôler le scrolling
var scroll_speed = 50  # Pixels par seconde
var label: Label
var label2: Label

func _ready():
	# Obtenir les labels enfants
	label = $Label2
	label2 = $Label3
	# Initialiser la position des labels en dehors de l'écran à droite
	label.position.x = size.x
	label2.position.y = size.y

func _process(delta):
	# Calculer le milieu de l'écran en X pour label
	var middle_x = size.x / 2 - label.size.x / 2
	# Calculer le milieu de l'écran en Y pour label2
	var middle_y = size.y / 2 - label2.size.y / 2
	
	# Déplacer le label vers la gauche jusqu'à ce qu'il atteigne le milieu de l'écran
	if label.position.x > middle_x:
		label.position.x -= scroll_speed * delta
		
	# Déplacer le label2 vers le haut jusqu'à ce qu'il atteigne le milieu de l'écran
	if label2.position.y > middle_y:
		label2.position.y -= scroll_speed * delta

	# Empêcher le label de sortir de l'écran
	if label.position.x < middle_x:
		label.position.x = middle_x
		
	# Empêcher le label2 de sortir de l'écran
	if label2.position.y < middle_y:
		label2.position.y = middle_y



func _on_btn_play_click_end():
	var _level = get_tree().change_scene_to_file(level)

func _on_btn_exit_click_end():
	get_tree().quit()
	

