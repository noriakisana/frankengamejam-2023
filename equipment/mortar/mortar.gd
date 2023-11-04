extends Equipment

@export var processing_time = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	$ProgressBar.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	if is_processing:
		var bar_width = ((processing_time - $ProcessTimer.time_left) / processing_time) * 40.0
		$ProgressBar.size.x = bar_width
	
func is_compatible(useable : Useable):
	return useable is Ingredient and useable.type == Ingredient.Type.UNICORN

func start_processing():
	is_processing = true
	$ProgressBar.visible = true
	$ProcessTimer.wait_time = processing_time
	$ProcessTimer.start()
	$AnimationPlayer.play("mortar_animation")

func _on_process_timer_timeout():
	$ProgressBar.visible = false
	if placed_useable.type == Ingredient.Type.UNICORN:
		placed_useable = load("res://ingredients/grinded_unicorn/grinded_unicorn.tres")
		useable_node.queue_free()
		useable_node = placed_useable.get_scene()
		useable_node.scale = Vector2(0.7, 0.7)
		add_child(useable_node)
		is_processing = false
		$AnimationPlayer.stop()
		self.set_frame(0)

"""
func startAnimation():
	$AnimationPlayer.start("mortar_animation")

func stopAnimation():
	$AnimationPlayer.stop()
	self.set_frame(0)
"""
