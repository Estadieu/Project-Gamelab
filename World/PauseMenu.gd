extends PopupPanel

var menu = "res://TitleScreen/menu.tscn"
var map  = "res://World/world.tscn"

func _on_btn_resume_click_end():
	self.hide()
	get_tree().paused = false

func _on_btn_restart_click_end():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_btn_exit_click_end():
	get_tree().paused = false
	var _level = get_tree().change_scene_to_file(menu)
