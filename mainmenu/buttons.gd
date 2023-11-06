extends VBoxContainer

var first_focus = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartButton.grab_focus()

func _unhandled_input(event):
	if event is InputEventKey or event is InputEventJoypadButton:
		if event.is_action_pressed("exit_game"):
			get_tree().quit()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
