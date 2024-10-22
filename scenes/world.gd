extends Node2D

var slime_scene = preload("res://scenes/monster/slime.tscn")
var max_slime = 6
var current_slime = 0

var spawn_area_min = Vector2(1000, 500)  # Batas minimum
var spawn_area_max = Vector2(1300, 900)  # Batas maksimum

func _ready() -> void:
	$Respawn.start()

func _on_timer_timeout() -> void:
	if current_slime < max_slime:	
		print("timer ada")
		var slime = slime_scene.instantiate()
		var random_x = randf_range(spawn_area_min.x, spawn_area_max.x)
		var random_y = randf_range(spawn_area_min.y, spawn_area_max.y)
		slime.position = Vector2(random_x, random_y)
		add_child(slime)
		current_slime += 1
		print("slime respawn")
	else :
		$Respawn.stop()
		print("kelebihan tet")

func start_respawn() -> void:
	current_slime = 0  # Reset jumlah slime
	$Respawn.start()  # Mulai kembali timer
	print("Respawn timer started")
