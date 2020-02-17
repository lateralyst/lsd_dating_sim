extends ProgressBar

onready var main_script

func _ready():
	main_script = get_node("/root/GameManager/Main")
	self.value = self.max_value

func _process(delta):
	if main_script:
		self.value = (1.0 - (main_script.tracked_movement / main_script.max_tracked_movement)) * self.max_value
	pass
