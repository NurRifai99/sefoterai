extends Node2D


func _ready():
	get_node("Player").connect("player_died", self, "_on_player_died")  # Corrected line

func _on_player_died():
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
