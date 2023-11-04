extends Player

class_name Player_2

@onready var player_1 : Player = get_tree().get_first_node_in_group("player")

func _ready():
	receive_useable(load("res://ingredients/heart.tres"))
	#player_1.interacted.connect(hand_over_useable)

func _unhandled_input(event):
	var animationPlayer = $Visual/AnimationPlayer
	
	if event is InputEventKey:
		if event.is_action_pressed("walk_right_p2"):
			right_pressed = 1
			get_node("Visual").set_flip_h(false)
			animationPlayer.play("player_walk")
		if event.is_action_pressed("walk_left_p2"):
			left_pressed = 1
			get_node("Visual").set_flip_h(true)
			animationPlayer.play("player_walk")
		if event.is_action_pressed("walk_down_p2"):
			down_pressed = 1
			animationPlayer.play("player_walk")
		if event.is_action_pressed("walk_up_p2"):
			up_pressed = 1
			animationPlayer.play("player_walk")			

		if event.is_action_released("walk_right_p2"):
			right_pressed = 0
			animationPlayer.stop()
		if event.is_action_released("walk_left_p2"):
			left_pressed = 0
			animationPlayer.stop()
		if event.is_action_released("walk_down_p2"):
			down_pressed = 0
			animationPlayer.stop()
		if event.is_action_released("walk_up_p2"):
			up_pressed = 0
			animationPlayer.stop()

func _physics_process(delta):
	super(delta)
	# interacting
	if Input.is_action_just_pressed("interact_p2"):
		var vec_to_player_1 = player_1.position - position
		var dist = vec_to_player_1.length()
		if dist <= interaction_distance: # players are near to each other
			if !useable_in_hand:
				return
			if player_1.useable_in_hand:
				return
			# useable in hand
			player_1.receive_useable(lose_useable())
		else:
			interacted.emit(false, useable_in_hand)
