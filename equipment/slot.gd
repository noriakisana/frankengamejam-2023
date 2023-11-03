extends Sprite2D

@export var placed_potion : Potion

@onready var player_1 : Player = get_tree().get_first_node_in_group("player")
@onready var player_2 : Player = get_tree().get_nodes_in_group("player")[1]

func _ready():
	self.placed_potion = load("res://traenke/trank_green/green_potion.tres")
	var potion_node = placed_potion.get_scene().instantiate()
	potion_node.scale = Vector2(0.7, 0.7)
	add_child(potion_node)
	
	$InteractionBackground.visible = false
	
	player_1.interacted.connect(interact)

func _process(delta):
	var vec_to_player_1 : Vector2 = player_1.position - position
	var distance_to_player_1 = vec_to_player_1.length()
	var vec_to_player_2 : Vector2 = player_2.position - position
	var distance_to_player_2 = vec_to_player_2.length()
	if distance_to_player_1 <= 64 or distance_to_player_2 <= 64:
		$InteractionBackground.visible = true
	else:
		$InteractionBackground.visible = false

func interact(is_player_1 : bool):
	pass
