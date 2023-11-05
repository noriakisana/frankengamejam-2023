extends Sprite2D

class_name Cauldron

@export var interaction_distance : float = 64
@export var processing_time = 5

@onready var player_1 : Player = get_tree().get_first_node_in_group("player")
@onready var player_2 : Player = get_tree().get_nodes_in_group("player")[1]

@onready var container = $Control/HBoxContainer

@onready var recipe_panel : PackedScene = preload("res://cauldrons/recipe_panel/RecipePanel.tscn")

var is_processing = false

var recipe = []

func _ready():
	player_1.interacted.connect(interact)
	player_2.interacted.connect(interact)
	
	generate_recipe()

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
		if !player_useable: # player is nothing holding in hand
			return
		if !player_useable is Potion:
			pass
		if is_needed_for_recipe(player_useable):
			var useable_from_player = player.lose_useable()
			remove_from_recipe(useable_from_player)
			print(recipe)

func generate_recipe():
	recipe = [
		load("res://ingredients/snake/snake.tres"),
		load("res://ingredients/dragonheart/dragonheart.tres")
	]
	
	for child in container.get_children():
		child.queue_free()
	
	"""
	for r in recipe:
		var rp = recipe_panel.instantiate()
		rp.get_node("Ingredient").texture = r.get_scene().get_root().texture
		container.add_node(rp)
	"""
	
func is_needed_for_recipe(ingredient : Ingredient):
	var recipe_types = []
	for r in recipe:
		recipe_types.append(r.type)
		
	return recipe_types.has(ingredient.type)

func remove_from_recipe(ingredient : Ingredient):
	for r in recipe:
		if ingredient.type == r.type:
			recipe.erase(r)
			break
