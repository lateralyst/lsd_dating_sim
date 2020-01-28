extends Sprite3D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
func _process(delta):
	var camera_pos = get_viewport().get_camera().global_transform.origin
	var camera_dir = -get_viewport().get_camera().global_transform.basis.z
	camera_pos.y = 0
	
    
	camera_pos += 10000 * camera_dir
	
	look_at(camera_pos, Vector3(0, 1, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
