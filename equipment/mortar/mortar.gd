extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func startAnimation():
	$AnimationPlayer.start("mortar_animation")

func stopAnimation():
	$AnimationPlayer.stop()
	self.set_frame(0)
