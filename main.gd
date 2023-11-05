extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.is_action_pressed("exit_game"):
			get_tree().change_scene_to_file("res://mainmenu/mainmenu.tscn")
