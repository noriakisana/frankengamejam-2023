extends Useable

class_name Ingredient

enum Type {
	FAIRYDUST,
	UNICORN,
	GRINDED_UNICORN,
	FROG,
	FRIED_FROG,
	HEART,
	SNAKE,
	CHOPPED_HEART,
	FRIED_SNAKE
}

@export var type : Type

func _init(type=Type.FAIRYDUST):
	self.type = type

func get_scene():
	if self.type == Type.FAIRYDUST:
		return load("res://ingredients/fairydust/fairydust.tscn").instantiate()
	elif self.type == Type.UNICORN:
		return load("res://ingredients/unicorn/unicorn.tscn").instantiate()
	elif self.type == Type.GRINDED_UNICORN:
		return load("res://ingredients/grinded_unicorn/grinded_unicorn.tscn").instantiate()
	elif self.type == Type.FROG:
		return load("res://ingredients/frog/frog.tscn").instantiate()
	elif self.type == Type.FRIED_FROG:
		return load("res://ingredients/fried_frog/fried_frog.tscn").instantiate()
	elif self.type == Type.HEART:
		return load("res://ingredients/dragonheart/dragonheart.tscn").instantiate()
	elif self.type == Type.SNAKE:
		return load("res://ingredients/snake/snake.tscn").instantiate()
	elif self.type == Type.CHOPPED_HEART:
		return load("res://ingredients/dragonheartslices/dragonheartslices.tscn").instantiate()
	elif self.type == Type.FRIED_SNAKE:
		return load("res://ingredients/fried_snake/fried_snake.tscn").instantiate()

func get_image():
	if self.type == Type.FAIRYDUST:
		return load("res://ingredients/fairydust/fairydust.png")
	elif self.type == Type.UNICORN:
		return load("res://ingredients/unicorn/unicorn1.png")
	elif self.type == Type.GRINDED_UNICORN:
		return load("res://ingredients/grinded_unicorn/grinded_unicorn.png")
	elif self.type == Type.FROG:
		return load("res://ingredients/frog/frog.png")
	elif self.type == Type.FRIED_FROG:
		return load("res://ingredients/fried_frog/fried_frog.png")
	elif self.type == Type.HEART:
		return load("res://ingredients/dragonheart/dragonheart.png")
	elif self.type == Type.SNAKE:
		return load("res://ingredients/snake/snake.png")
	elif self.type == Type.CHOPPED_HEART:
		return load("res://ingredients/dragonheartslices/dragonheartslices.png")
	elif self.type == Type.FRIED_SNAKE:
		return load("res://ingredients/fried_snake/fried_snake.png")

