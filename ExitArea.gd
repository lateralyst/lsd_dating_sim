extends Spatial

const otherSceneFile = "res://scenes/World.tscn"
var otherScene

func _ready():
	var topNode = get_node("/root").get_child(0).filename;
	
	if topNode == otherSceneFile:
		pass
	else:
		otherScene = load(otherSceneFile)
		pass

func interact():
	if otherScene == null:
		print("can't exit to null scene")
	else:
		print("exiting to scene " + otherScene.get_name() + "...")
		get_tree().change_scene_to(otherScene)