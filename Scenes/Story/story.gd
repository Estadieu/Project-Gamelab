extends Control

const level = "res://Scenes/Level/level.tscn"

const sentences = [
	"Tu as enfin réussir à avoir ton ERAMUS",
	"Parmis toutes les possibilités, tu as choisi...",
	"Roulement de tambours...",
	"La Norvège (oui, c'est dans le nom du jeu)",
	"À toi les bars, les fêtes et l'alcool",
	"Es-tu prêt ?",
	"Oups, on a pas fait le bouton pour dire non",
	"3",
	"2",
	"1",
	"Bonne chance !"
]

const end_speed_start = 7

var current = 0

@onready var tree = get_tree()

func _ready():
	$Label.text = sentences[current]

func _on_timer_end():
	current += 1
	
	$Timer.stop()
	
	if current >= sentences.size():
		tree.change_scene_to_file(level)
		return
	
	if current == end_speed_start:
		$Timer.wait_time = 0.5
	
	var tween = create_tween()
	tween.tween_property($Label, "modulate", Color(255, 255, 255, 0.0), 0.5)
	tween.tween_callback(func(): $Label.text = sentences[current])
	tween.tween_property($Label, "modulate", Color(255, 255, 255, 1.0), 0.5)
	tween.tween_callback(func(): $Timer.start())
	tween.play()

func _unhandled_input(event):
	if event is InputEventKey:
		tree.change_scene_to_file(level)
