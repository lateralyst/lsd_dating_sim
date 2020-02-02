extends Node

func _ready():
	var player = get_parent()
	var interactables = get_tree().get_nodes_in_group("interactable")
	for i in range(interactables.size()):
		var node = get_node(interactables[i].get_path())
		var area = node.get_node("InteractBox")
		
		if area == null:
			area = node.get_node("Area") # alternative name
		
		if area != null:
			var args = Array([node])
			area.connect("body_entered", player, "_on_area2d_body_entered", args)
			area.connect("body_exited", player, "_on_area2d_body_exited", args)
		else:
			print("error: area node not found")
