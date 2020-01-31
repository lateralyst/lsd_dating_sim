extends Node

func _ready():
	var player = get_parent()
	print(player)
	var interactables = get_tree().get_nodes_in_group("interactable")
	for i in range(interactables.size()):
		var node = get_node(interactables[i].get_path())
		var area2d = node.get_node("InteractBox")
		var args = Array([node])
		area2d.connect("body_entered", player, "_on_area2d_body_entered", args)
		area2d.connect("body_exited", player, "_on_area2d_body_exited", args)