extends Label

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for portal in get_tree().get_nodes_in_group("portal"):
		portal.potion_placed.connect(increase_score)
	
	self.text = "Score: " + str(score)

func reset_score():
	score = 0

func increase_score(delta_score):
	score = score + delta_score
	self.text = "Score: " + str(score)
