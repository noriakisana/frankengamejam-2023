extends Useable

class_name Ingredient

enum Type {
	FAIRYDUST,
	UNICORN,
	GRINDED_UNICORN,
	FROG,
	HEART,
	SNAKE,
	CHOPPED_HEART
}

@export var type : Type

func get_scene():
	if self.type == Type.FAIRYDUST:
		return load("res://ingredients/fairydust/fairydust.tscn").instantiate()
	elif self.type == Type.UNICORN:
		return load("res://ingredients/unicorn/unicorn.tscn").instantiate()
	elif self.type == Type.GRINDED_UNICORN:
		return load("res://ingredients/grinded_unicorn/grinded_unicorn.tscn").instantiate()
	elif self.type == Type.FROG:
		return load("res://ingredients/frog/frog.tscn").instantiate()
	elif self.type == Type.HEART:
		return load("res://ingredients/dragonheart/dragonheart.tscn").instantiate()
	elif self.type == Type.SNAKE:
		return load("res://ingredients/snake/snake.tscn").instantiate()
	elif self.type == Type.CHOPPED_HEART:
		return load("res://ingredients/dragonheartslices/dragonheartslices.tscn").instantiate()
