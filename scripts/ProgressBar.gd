extends ProgressBar

onready var player

func _ready():
	player = weakref(get_tree().get_nodes_in_group("Player")[0])
	self.value = self.max_value

func _process(delta):
	if !player.get_ref():
		player = weakref(get_tree().get_nodes_in_group("Player")[0])
	self.value = (1.0 - (player.get_ref().tracked_movement / player.get_ref().max_tracked_movement)) * self.max_value
	pass
