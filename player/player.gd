extends CharacterBody2D

class_name Player

signal interacted(is_p1)

@export var is_player_1 = true
@export var speed : float = 128
@export var potion_in_hand : Potion

var left_pressed = 0
var right_pressed = 0
var up_pressed = 0
var down_pressed = 0

var dir : Vector2

func _unhandled_input(event):
	var animationPlayer = $Visual/AnimationPlayer
	if is_player_1:
		if event is InputEventKey:
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
				print("test")
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
	if Input.is_action_just_pressed("interact_p1"):
		interacted.emit(is_player_1)

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
