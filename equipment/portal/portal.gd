extends Equipment

signal potion_placed(delta_score)

#var label : Label = get_tree().get_first_node_in_group("label");
# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	$AnimationPlayer.play("portal_animation")
	$ProgressBar.visible = false


	
func is_compatible(useable : Useable):
	return useable is Potion

func start_processing():
	potion_placed.emit(1)
	#Score.increaseScore(1)
	useable_node.startPortalAnimation()
	await get_tree().create_timer(2.1).timeout
	useable_node.queuee_free()
	placed_useable = null
	#is_processing = true
		#$ProgressBar.visible = true
	#$ProcessTimer.wait_time = processing_time
	#$ProcessTimer.start()
	#$AnimationPlayer.play("mortar_animation")

#func _on_process_timer_timeout():
#	$ProgressBar.visible = false
#	if placed_useable.type == Ingredient.Type.UNICORN:
#		placed_useable = load("res://ingredients/grinded_unicorn/grinded_unicorn.tres")
#		useable_node.queue_free()
#		useable_node = placed_useable.get_scene()
#		useable_node.scale = Vector2(0.7, 0.7)
#		add_child(useable_node)
#		is_processing = false
#		$AnimationPlayer.stop()
#		self.set_frame(0)

"""
func startAnimation():
	$AnimationPlayer.start("mortar_animation")

func stopAnimation():
	$AnimationPlayer.stop()
	self.set_frame(0)
"""
