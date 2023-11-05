extends Node

@export var time_limit : int = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = time_limit
	$TimeUpText.visible = false
	
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time_left = $Timer.time_left
	var minutes : int = int(time_left) / 60
	var seconds : int = int(time_left) % 60
	var formatted_time : String = "%02d:%02d" % [minutes, seconds]
	$TimeText.text = formatted_time
	if minutes == 0 and seconds <= 10:
		$TimeText.modulate = Color(1, 0, 0)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.is_action_pressed("exit_game"):
			$Timer.stop()
			get_tree().change_scene_to_file("res://mainmenu/mainmenu.tscn")

func _on_timer_timeout():
	$TimeUpText.visible = true
	get_tree().paused = true
