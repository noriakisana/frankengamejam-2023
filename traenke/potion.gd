extends Useable

class_name Potion

enum Type {
	EMPTY,
	GREEN
}

@export var type : Type

func _init(type=Type.EMPTY):
	self.type = type

func get_scene():
	if self.type == Type.EMPTY:
		return load("res://traenke/trank_leer/trank_leer.tscn").instantiate()
	elif self.type == Type.GREEN:
		return load("res://traenke/trank_green/trank_green.tscn").instantiate()
