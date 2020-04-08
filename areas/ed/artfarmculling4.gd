extends Spatial

var base_translation = Vector3(0,0,0)
var mvmt = 4000

func _ready():
	pass
	
func _process(delta):
	var speed = delta *10
	mvmt += speed
	base_translation + Vector3(0, sin(mvmt), 0)
	pass
