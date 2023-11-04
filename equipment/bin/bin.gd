extends Equipment

func _ready():
	super()
	self.placed_useable = load("res://ingredients/dragonheart/dragonheart.tres")
	useable_node = placed_useable.get_scene()
	useable_node.scale = Vector2(0.7, 0.7)
	add_child(useable_node)

func is_compatible(useable : Useable):
	return false
