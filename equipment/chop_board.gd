extends Equipment

@export var processing_time = 5

func _ready():
	super()
	$ProgressBar.visible = false

func _process(delta):
	if is_processing:
		var bar_width = ((processing_time - $ProcessTimer.time_left) / processing_time) * 40.0
		$ProgressBar.size.x = bar_width

func is_compatible(useable : Useable):
	return useable is Ingredient and useable.type == Ingredient.Type.HEART

func start_processing():
	is_processing = true
	$ProgressBar.visible = true
	$ProcessTimer.wait_time = processing_time
	$ProcessTimer.start()

func _on_process_timer_timeout():
	$ProgressBar.visible = false
	if placed_useable.type == Ingredient.Type.HEART:
		placed_useable = load("res://ingredients/chopped_heart.tres")
		useable_node.queue_free()
		useable_node = placed_useable.get_scene()
		useable_node.scale = Vector2(0.7, 0.7)
		add_child(useable_node)
		is_processing = false
