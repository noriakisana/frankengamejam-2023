extends Equipment

func is_compatible(useable : Useable):
	return useable is Ingredient and useable.type == Ingredient.Type.HEART
