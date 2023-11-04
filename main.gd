extends Node

var score = 0

func resetScore():
	score = 0

func increaseScore(i):
	score = score + i


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.is_action_pressed("exit_game"):
			get_tree().change_scene_to_file("res://mainmenu/mainmenu.tscn")
