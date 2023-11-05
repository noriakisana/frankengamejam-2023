extends Player

class_name Player_1

@onready var player_2 : Player = get_tree().get_nodes_in_group("player")[1]

func _ready():
	pass

func _unhandled_input(event):
	var animationPlayer = $Visual/AnimationPlayer
	
	if event is InputEventKey or event is InputEventJoypadMotion:
		if event.is_action_pressed("walk_right_p1"):
			right_pressed = 1
			get_node("Visual").set_flip_h(false)
			animationPlayer.play("player_walk")
		if event.is_action_pressed("walk_left_p1"):
			left_pressed = 1
			get_node("Visual").set_flip_h(true)
			animationPlayer.play("player_walk")
		if event.is_action_pressed("walk_down_p1"):
			down_pressed = 1
			animationPlayer.play("player_walk")
		if event.is_action_pressed("walk_up_p1"):
			up_pressed = 1
			animationPlayer.play("player_walk")	
		
		if event.is_action_pressed("run_p1"):
			is_running = true
			
					
		if event.is_action_released("walk_right_p1"):
			right_pressed = 0
			animationPlayer.stop()
		if event.is_action_released("walk_left_p1"):
			left_pressed = 0
			animationPlayer.stop()
		if event.is_action_released("walk_down_p1"):
			down_pressed = 0
			animationPlayer.stop()
		if event.is_action_released("walk_up_p1"):
			up_pressed = 0
			animationPlayer.stop()
			
		if event.is_action_released("run_p1"):
			is_running = false

func _physics_process(delta):
	super(delta)
	# interacting
	if Input.is_action_just_pressed("interact_p1"):
		var vec_to_player_2 = player_2.position - position
		var dist = vec_to_player_2.length()
		if dist <= interaction_distance: # players are near to each other
			if !useable_in_hand:
				return
			if player_2.useable_in_hand:
				return
			# useable in hand
			player_2.receive_useable(lose_useable())
		else:
			interacted.emit(true, useable_in_hand)
