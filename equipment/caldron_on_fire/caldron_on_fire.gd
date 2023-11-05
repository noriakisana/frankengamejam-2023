extends Equipment

class_name caldron_on_fire

@export var processing_time = 5
var ingredients = []


@onready var panel_template = preload("res://equipment/caldron_on_fire/recipe_panel/RecipePanel.tscn")

@onready var container = $Control/HBoxContainer


func _ready():
	super()
	new_recipe()
	
	$ProgressBar.visible = false
	
	#var texture_rect = TextureRect.new()
	#texture_rect.texture = load("res://ingredients/unicorn/unicorn1.png")
	
func show_recipe():
	for item_type in recipe:
		var ingredient = panel_template.instantiate()
		ingredient.type = item_type
		var texture_rect = ingredient.get_child(0)
		texture_rect.set_texture(get_ingredient_img(item_type))
		
		container.add_child(ingredient)
		

	
		
func get_ingredient_img(ingredient_type: Type):
	if ingredient_type == Ingredient.Type.FAIRYDUST:
		return load("res://ingredients/fairydust/fairydust.png")
	elif ingredient_type == Ingredient.Type.UNICORN:
		return load("res://ingredients/unicorn/unicorn1.png")
	elif ingredient_type == Ingredient.Type.GRINDED_UNICORN:
		return load("res://ingredients/grinded_unicorn/grinded_unicorn.png")
	elif ingredient_type == Ingredient.Type.FROG:
		return load("res://ingredients/frog/frog.png")
	elif ingredient_type == Ingredient.Type.FRIED_FROG:
		return load("res://ingredients/fried_frog/fried_frog.png")
	elif ingredient_type == Ingredient.Type.HEART:
		return load("res://ingredients/dragonheart/dragonheart.png")
	elif ingredient_type == Ingredient.Type.SNAKE:
		return load("res://ingredients/snake/snake.png")
	elif ingredient_type == Ingredient.Type.CHOPPED_HEART:
		return load("res://ingredients/dragonheartslices/dragonheartslices.png")
	elif ingredient_type == Ingredient.Type.FRIED_SNAKE:
		return load("res://ingredients/fried_snake/fried_snake.png")
	

func _process(delta):
	super(delta)
	if is_processing:
		var bar_width = ((processing_time - $ProcessTimer.time_left) / processing_time) * 40.0
		$ProgressBar.size.x = bar_width
		

func is_compatible(useable : Useable):
	return recipe.has(useable.type)

func new_recipe():
	recipeSize = recipe.size()
	recipe.clear()
	var num = randi_range(1,3)
	var item
	for i in range(num):
		item = randi() % Ingredient.ingredients.size()
		recipe.append(Ingredient.ingredients[item])
	show_recipe()

	
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
		new_recipe()
		process_potion()
		
func item_added_to_caldron(type: Type):		
	for panel in container.get_children():
		if type == panel.type:
			container.remove_child(panel)
			break
		
func _on_process_timer_timeout():
		placed_useable = load("res://traenke/trank_green/green_potion.tres")
		useable_node = placed_useable.get_scene()
		useable_node.scale = Vector2(0.7, 0.7)
		add_child(useable_node)
		is_processing = false
		$ProgressBar.visible = false
		$AnimationPlayer.stop()
