extends Node2D

var slime_scene = preload("res://scenes/monster/slime.tscn")
<<<<<<< HEAD
var snake_scene = preload("res://scenes/monster/snake.tscn")
var max_slime = 4
var max_snake = 3
var current_slime = 0
var current_snake = 0
=======
var max_slime = 6
var current_slime = 0
>>>>>>> 5ed8c84aca1f9a5d55b13ab00f6c37af6e1bd316

var spawn_area_min = Vector2(1000, 500)  # Batas minimum
var spawn_area_max = Vector2(1300, 900)  # Batas maksimum

func _ready() -> void:
	$Respawn.start()

func _on_timer_timeout() -> void:
	if current_slime < max_slime:	
		print("timer ada")
		var slime = slime_scene.instantiate()
<<<<<<< HEAD
		var snake = snake_scene.instantiate()
		var random_x = randf_range(spawn_area_min.x, spawn_area_max.x)
		var random_y = randf_range(spawn_area_min.y, spawn_area_max.y)
		slime.position = Vector2(random_x, random_y)
		snake.position = Vector2(random_x, random_y)
		add_child(slime)
		add_child(snake)
		current_slime += 1
		current_snake += 1
=======
		var random_x = randf_range(spawn_area_min.x, spawn_area_max.x)
		var random_y = randf_range(spawn_area_min.y, spawn_area_max.y)
		slime.position = Vector2(random_x, random_y)
		add_child(slime)
		current_slime += 1
>>>>>>> 5ed8c84aca1f9a5d55b13ab00f6c37af6e1bd316
		print("slime respawn")
	else :
		$Respawn.stop()
		print("kelebihan tet")

func start_respawn() -> void:
	current_slime = 0  # Reset jumlah slime
<<<<<<< HEAD
	current_snake = 0
=======
>>>>>>> 5ed8c84aca1f9a5d55b13ab00f6c37af6e1bd316
	$Respawn.start()  # Mulai kembali timer
	print("Respawn timer started")
