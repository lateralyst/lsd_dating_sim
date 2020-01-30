extends ProgressBar

onready var player = get_node("../../Player")

func _ready():
	self.value = self.max_value

func _process(delta):
	self.value = (1.0 - (player.tracked_movement / player.max_tracked_movement)) * self.max_value