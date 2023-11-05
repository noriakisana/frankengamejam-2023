extends Equipment

class_name caldron_on_fire

@export var processing_time = 5
var ingredients = []
var recipe = [Ingredient.Type.HEART, Ingredient.Type.FROG]
#var recipe2 = [Ingredient.Type.FRIED_FROG, Ingredient.Type.GRINDED_UNICORN]
func _ready():
	super()
	$ProgressBar.visible = false

func _process(delta):
	super(delta)
	if is_processing:
		var bar_width = ((processing_time - $ProcessTimer.time_left) / processing_time) * 40.0
		$ProgressBar.size.x = bar_width
		

func is_compatible(useable : Useable):
	return useable is Ingredient


	
func process_potion():
	is_processing = true
	$ProgressBar.visible = true
	$ProcessTimer.wait_time = processing_time
	$ProcessTimer.start()
	$AnimationPlayer.play("caldron_on_fire_animation")

func start_processing():
	
	var fullfilled = true
	for ingredient in recipe:
		
		if !ingredients.has(ingredient):
			fullfilled = false
	if fullfilled:
		process_potion()
		
func _on_process_timer_timeout():
		placed_useable = load("res://traenke/trank_green/green_potion.tres")
		useable_node = placed_useable.get_scene()
		useable_node.scale = Vector2(0.7, 0.7)
		add_child(useable_node)
		is_processing = false
		$ProgressBar.visible = false
		$AnimationPlayer.stop()
