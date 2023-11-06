extends Node

func _unhandled_input(event):
	if event is InputEventKey:
		if event.is_action_pressed("exit_game"):
			#get_parent().get_node("Timer").stop()
			get_tree().change_scene_to_file("res://mainmenu/mainmenu.tscn")
