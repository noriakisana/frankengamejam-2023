extends Sprite2D

@export var interaction_distance : float = 64
@export var ingredient : Ingredient

@onready var player_1 : Player = get_tree().get_first_node_in_group("player")
@onready var player_2 : Player = get_tree().get_nodes_in_group("player")[1]

func _ready():
	# labels
	var bin_label = ingredient.get_scene()
	bin_label.scale = Vector2(0.7, 0.7)
	add_child(bin_label)
	
	# interactions
	player_1.interacted.connect(interact)
	player_2.interacted.connect(interact)

func interact(is_player_1 : bool, useable : Useable):
	var vec_to_player_1 : Vector2 = player_1.position - position
	var distance_to_player_1 = vec_to_player_1.length()
	var vec_to_player_2 : Vector2 = player_2.position - position
	var distance_to_player_2 = vec_to_player_2.length()
	
	var player : Player
	var distance_to_player : float
	if is_player_1:
		player = player_1
		distance_to_player = distance_to_player_1
	else:
		player = player_2
		distance_to_player = distance_to_player_2
		
	if distance_to_player <= interaction_distance:
		if player.useable_in_hand:
			return
		player.receive_useable(ingredient)
