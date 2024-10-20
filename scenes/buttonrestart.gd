extends Control

func _ready() -> void:
	# Connect the buttons to their respective functions
	$Button.connect("pressed", Callable(self, "_on_restart_button_pressed"))
	#$ExitButton.connect("pressed", self, "_on_exit_button_pressed")

func _on_restart_button_pressed() -> void:
	# Restart the game by changing back to the world scene
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_exit_button_pressed() -> void:
	# Quit the game
	get_tree().quit()
