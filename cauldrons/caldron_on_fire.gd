extends Sprite2D

class_name Cauldron

@export var interaction_distance : float = 64
@export var processing_time = 5
@export var maximum_recipe_size = 3

@onready var player_1 : Player = get_tree().get_first_node_in_group("player")
@onready var player_2 : Player = get_tree().get_nodes_in_group("player")[1]

@onready var container = $Control/HBoxContainer

@onready var recipe_panel : PackedScene = preload("res://cauldrons/recipe_panel/RecipePanel.tscn")

var is_processing = false

var recipe = []
#var ingredients = []

var potion : Potion
var potion_node : Node2D

func _ready():
	player_1.interacted.connect(interact)
	player_2.interacted.connect(interact)
	
	$ProgressBar.visible = false
	
	generate_recipe()
	fill_recipe_panel()

func _process(delta):
	if is_processing:
		var bar_width = ((processing_time - $ProcessTimer.time_left) / processing_time) * 40.0
		$ProgressBar.size.x = bar_width

func interact(is_player_1 : bool, player_useable : Useable):
	var player : Player
	var distance_to_player : float
	if is_player_1:
		player = player_1
		var vec_to_player_1 : Vector2 = player_1.position - position
		distance_to_player = vec_to_player_1.length()
	else:
		player = player_2
		var vec_to_player_2 : Vector2 = player_2.position - position
		distance_to_player = vec_to_player_2.length()
	
	if distance_to_player <= interaction_distance:
		if is_processing: # currently cooking a potion
			return
		if !potion: # no potion in cauldron
			if !player_useable: # player is holding noting in hand
				return
			if is_needed_for_recipe(player_useable):
				var useable_from_player = player.lose_useable()
				#ingredients.append(useable_from_player)
				remove_from_recipe(useable_from_player)
				if recipe.is_empty(): # let's get cookin'
					start_brewing()
		else: # there is a potion waiting to get collected
			if player_useable: # player is holding something in hand
				return
			player.receive_useable(potion)
			potion = null
			potion_node.queue_free()

func start_brewing():
	is_processing = true
	$ProgressBar.visible = true
	$ProcessTimer.wait_time = processing_time
	$AnimationPlayer.play("caldron_on_fire_animation")
	$ProcessTimer.start()

func _on_process_timer_timeout():
	$ProgressBar.visible = false
	$AnimationPlayer.stop()
	potion = load("res://traenke/trank_green/green_potion.tres")
	potion_node = potion.get_scene()
	potion_node.scale = Vector2(0.5, 0.5)
	potion_node.position.y -= 10
	add_child(potion_node)
	generate_recipe()
	fill_recipe_panel()
	is_processing = false

func generate_recipe():
	var recipe_size = randi() % maximum_recipe_size + 1
	recipe = []
	for i in range(recipe_size):
		var ing_type = randi() % Ingredient.Type.size()
		var ing_res = Ingredient.new(ing_type)
		recipe.append(ing_res)

func fill_recipe_panel():
	for r in recipe:
		var ing_node = recipe_panel.instantiate()
		var ing_img = r.get_image()
		ing_node.get_node("Ingredient").texture = ing_img
		container.add_child(ing_node)

"""
func clear_recipe_panel():
	for child in container.get_children():
		child.queue_free()
"""
	
func is_needed_for_recipe(ingredient : Ingredient):
	var recipe_types = []
	for r in recipe:
		recipe_types.append(r.type)
		
	return recipe_types.has(ingredient.type)

func remove_from_recipe(ingredient : Ingredient):
	var remove_index
	for r in range(recipe.size()):
		if ingredient.type == recipe[r].type:
			recipe.remove_at(r)
			remove_index = r
			break
	container.get_child(remove_index).queue_free()
		
