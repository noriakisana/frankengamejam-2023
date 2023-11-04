extends VBoxContainer

var first_focus = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("exit_game"):
		get_tree().quit()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
