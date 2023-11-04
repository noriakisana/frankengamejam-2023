extends CharacterBody2D

class_name Player

signal interacted(is_player_1, useable)

@export var speed : float = 128
@export var useable_in_hand : Useable
@export var interaction_distance : float = 96
var useable_node : Node2D

var left_pressed = 0
var right_pressed = 0
var up_pressed = 0
var down_pressed = 0

var dir : Vector2

func _physics_process(delta):
	dir = Vector2(
		right_pressed - left_pressed,
		down_pressed - up_pressed
	).normalized()
	
	# moving
	velocity = dir * speed
	move_and_slide()

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

"""
func hand_over_useable(useable : Useable):
	var vec_position_players : Vector2 = player_1.position - player_2.position
	var distance_players = vec_position_players.length()
	if distance_players <= interaction_distance:
		if is_player_1:
			player_2.receive_useable(player_1.lose_useable())
		else:
			player_1.receive_useable(player_2.lose_useable())
"""
	
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
