extends Control

const story = "res://Scenes/Story/story.tscn"

@onready var tree = get_tree()

func _on_play_clicked():
	tree.change_scene_to_file(story)

func _on_exit_clicked():
	tree.quit()
