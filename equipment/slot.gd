extends Sprite2D

@export var placed_potion : Potion

func _ready():
	self.placed_potion = load("res://traenke/trank_green/green_potion.tres")
	var potion_node = placed_potion.get_scene().instantiate()
	potion_node.scale = Vector2(0.7, 0.7)
	add_child(potion_node)
