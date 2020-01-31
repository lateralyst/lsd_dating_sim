extends ProgressBar

onready var player

func _ready():
	player = get_node("/root").get_child(0).get_node("Player")
	self.value = self.max_value

func _process(delta):
	self.value = (1.0 - (player.tracked_movement / player.max_tracked_movement)) * self.max_value