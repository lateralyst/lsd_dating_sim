extends VBoxContainer

onready var main_script = get_node("/root/GameManager/Main")

func _on_Resume_pressed():
	get_tree().paused = false
	self.visible = false

func _on_Restart_pressed():
	main_script.reset_scene()

func _on_Quit_pressed():
	get_tree().paused = false	
	get_tree().quit()
