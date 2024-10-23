extends Area2D

var slime_scene = preload("res://scenes/monster/slime.tscn")

func _ready():
	randomize()
	var num_slimes = 10
	for i in range(num_slimes):
		var slime = slime_scene.instantiate()
		# Menghasilkan posisi acak di dalam area spawn
		var pos = position + Vector2(randf_range(0, 500), randf_range(700, 1000))  # Ubah rentang sesuai kebutuhan
		slime.position = pos
		get_parent().add_child(slime)  # Menambahkan slime ke parent scene
		print("Slime spawned at: ", pos)
