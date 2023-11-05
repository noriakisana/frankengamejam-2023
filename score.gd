extends Label

var score = 0

func resetScore():
	score = 0

func increaseScore(i):
	print("score")
	score = score + i
	
# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = "Score: " + str(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "Score: " + str(score)
