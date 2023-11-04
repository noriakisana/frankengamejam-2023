extends Useable

class_name Ingredient

enum Type {
	FAIRYDUST,
	UNICORN,
	FROG,
	HEART,
	SNAKE,
	CHOPPED_HEART
}

@export var type : Type
@export var texture : AtlasTexture

var scene : PackedScene = load("res://ingredients/world_ingredient.tscn")

func get_scene():
	var output = scene.instantiate()
	output.texture = texture
	
	return output
