extends CharacterBody2D

class_name Player

signal interacted(is_p1, potion)

@export var is_player_1 = true
@export var speed : float = 128
@export var useable_in_hand : Useable
@export var interaction_distance : float = 92
var useable_node : Node2D

@onready var player_1 : Player = get_tree().get_first_node_in_group("player")
@onready var player_2 : Player = get_tree().get_nodes_in_group("player")[1]

var left_pressed = 0
var right_pressed = 0
var up_pressed = 0
var down_pressed = 0

var dir : Vector2

func _ready():
	if is_player_1:
		receive_useable(load("res://ingredients/fairydust.tres"))
	else:
		receive_useable(load("res://ingredients/heart.tres"))
		
	player_1.interacted.connect(hand_over_useable)
	player_2.interacted.connect(hand_over_useable)

func _unhandled_input(event):
	var animationPlayer = $Visual/AnimationPlayer
	if is_player_1:
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
	else:
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
	dir = Vector2(
		right_pressed - left_pressed,
		down_pressed - up_pressed
	).normalized()
	
	# animation
	#change_animation_state()
	#update_animation_params()
	
	# moving
	velocity = dir * speed
	move_and_slide()
	#var motion = velocity * delta
	#move_and_collide(motion)
	
	# interacting
	if is_player_1 and Input.is_action_just_pressed("interact_p1"):
		interacted.emit(true, useable_in_hand)
	if !is_player_1 and Input.is_action_just_pressed("interact_p2"):
		interacted.emit(false, useable_in_hand)

func receive_useable(useable : Useable):
	if useable_in_hand:
		return false
	
	useable_in_hand = useable
	useable_node = useable.get_scene()
	useable_node.scale = Vector2(0.7, 0.7)
	add_child(useable_node)
	return true

func lose_useable():
	if !useable_in_hand:
		return null
	
	var output = useable_in_hand.duplicate()
	useable_in_hand = null
	useable_node.queue_free()
	return output

func hand_over_useable(is_player_1 : bool, useable : Useable):
	var vec_position_players : Vector2 = player_1.position - player_2.position
	var distance_players = vec_position_players.length()
	if distance_players <= interaction_distance:
		if is_player_1:
			player_2.receive_useable(player_1.lose_useable())
		else:
			player_1.receive_useable(player_2.lose_useable())
	
	
"""
func change_animation_state():
	if velocity != Vector2.ZERO:
		animation_state_machine.travel("Walk")
	else:
		animation_state_machine.travel("Idle")

func update_animation_params():
	if input_dir != Vector2.ZERO:
		animation_tree.set("parameters/Walk/blend_position", input_dir)
"""
