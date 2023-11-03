extends CharacterBody2D

class_name Player

signal interacted(is_p1, potion)

@export var is_player_1 = true
@export var speed : float = 128
@export var potion_in_hand : Potion
var potion_node : Node2D

var left_pressed = 0
var right_pressed = 0
var up_pressed = 0
var down_pressed = 0

var dir : Vector2

func _ready():
	pass
	#receive_potion(load("res://traenke/trank_leer/empty_potion.tres"))

func _unhandled_input(event):
	if is_player_1:
		if event is InputEventKey:
			if event.is_action_pressed("walk_right_p1"):
				right_pressed = 1
			if event.is_action_pressed("walk_left_p1"):
				left_pressed = 1
			if event.is_action_pressed("walk_down_p1"):
				down_pressed = 1
			if event.is_action_pressed("walk_up_p1"):
				up_pressed = 1
			
			if event.is_action_released("walk_right_p1"):
				right_pressed = 0
			if event.is_action_released("walk_left_p1"):
				left_pressed = 0
			if event.is_action_released("walk_down_p1"):
				down_pressed = 0
			if event.is_action_released("walk_up_p1"):
				up_pressed = 0
	else:
		if event is InputEventKey:
			if event.is_action_pressed("walk_right_p2"):
				right_pressed = 1
			if event.is_action_pressed("walk_left_p2"):
				left_pressed = 1
			if event.is_action_pressed("walk_down_p2"):
				down_pressed = 1
			if event.is_action_pressed("walk_up_p2"):
				up_pressed = 1
			
			if event.is_action_released("walk_right_p2"):
				right_pressed = 0
			if event.is_action_released("walk_left_p2"):
				left_pressed = 0
			if event.is_action_released("walk_down_p2"):
				down_pressed = 0
			if event.is_action_released("walk_up_p2"):
				up_pressed = 0

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
	if Input.is_action_just_pressed("interact_p1"):
		interacted.emit(is_player_1, potion_in_hand)

func receive_potion(potion : Potion):
	if potion_in_hand:
		return false
	
	potion_in_hand = potion
	potion_node = potion.get_scene().instantiate()
	potion_node.scale = Vector2(0.7, 0.7)
	add_child(potion_node)
	return true

func lose_potion():
	if !potion_in_hand:
		return null
	
	var output = potion_in_hand.duplicate()
	potion_in_hand = null
	potion_node.queue_free()
	return output

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
