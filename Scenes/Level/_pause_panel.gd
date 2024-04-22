extends Panel

@onready var tree = get_tree()

var home = "res://Scenes/Home/home.tscn"

func _on_btn_resume_click_end():
	visible     = false
	tree.paused = false

func _on_btn_restart_click_end():
	tree.paused = false
	tree.reload_current_scene()

func _on_btn_exit_click_end():
	tree.paused = false
	tree.change_scene_to_file(home)
