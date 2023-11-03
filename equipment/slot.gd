extends Sprite2D

@export var interaction_distance : float = 64
@export var placed_useable : Useable

@onready var player_1 : Player = get_tree().get_first_node_in_group("player")
@onready var player_2 : Player = get_tree().get_nodes_in_group("player")[1]

var distance_to_player_1 : float
var distance_to_player_2 : float

var useable_node : Node2D

func _ready():
	self.placed_useable = load("res://ingredients/snake.tres")
	useable_node = placed_useable.get_scene()
	useable_node.scale = Vector2(0.7, 0.7)
	add_child(useable_node)
	
	$InteractionBackground.visible = false
	
	player_1.interacted.connect(interact)
	player_2.interacted.connect(interact)

func _process(delta):
	var vec_to_player_1 : Vector2 = player_1.position - position
	distance_to_player_1 = vec_to_player_1.length()
	var vec_to_player_2 : Vector2 = player_2.position - position
	distance_to_player_2 = vec_to_player_2.length()
	if distance_to_player_1 <= interaction_distance or distance_to_player_2 <= interaction_distance:
		$InteractionBackground.visible = true
	else:
		$InteractionBackground.visible = false

func interact(is_player_1 : bool, useable : Useable):
	var player
	var distance_to_player
	if is_player_1:
		player = player_1
		distance_to_player = distance_to_player_1
	else:
		player = player_2
		distance_to_player = distance_to_player_2
	if distance_to_player <= interaction_distance:
		if placed_useable: # there is a placed usable
			var success = player.receive_useable(placed_useable)
			if success: # player can pickup useable
				useable_node.queue_free()
				placed_useable = null
		else:
			var player_useable = player.lose_useable()
			if !player_useable:
				return
			placed_useable = player_useable
			useable_node = placed_useable.get_scene()
			useable_node.scale = Vector2(0.7, 0.7)
			add_child(useable_node)
