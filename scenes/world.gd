extends Node2D

var player_scene = preload("res://scenes/player.tscn")  # Path ke scene player
var monster_scene = preload("res://scenes/monster/MonsterBase.tscn")  # Path ke scene monster

func _ready():
	# Menginstansiasi player di posisi tertentu
	var player = player_scene.instance()
	player.position = Vector2(400, 300)  # Ganti dengan posisi yang diinginkan
	add_child(player)

	# Menginstansiasi beberapa monster di posisi acak
	spawn_monsters(5)  # Spawning 5 monster

func spawn_monsters(count: int):
	for i in range(count):
		var monster = monster_scene.instance()
		add_child(monster)
		monster.position = Vector2(randf() * 800, randf() * 600)  # Ganti dengan ukuran dunia Anda
