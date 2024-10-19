extends CharacterBody2D

# Atribut dasar untuk semua monster
var health = 100
var damage = 10
var speed = 50
var target_player = null  # Referensi ke pemain yang ingin dikejar

# Fungsi untuk mengejar pemain
func _physics_process(delta):
	if target_player:
		chase_player(delta)

func chase_player(delta):
	# Hitung arah ke pemain
	var direction = (target_player.position - position).normalized()
	velocity = direction * speed  # Atur kecepatan sesuai arah
	move_and_slide()  # Panggil move_and_slide tanpa argumen

# Fungsi untuk menerima damage
func take_damage(amount):
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()  # Hapus monster dari scene

# Fungsi untuk mendeteksi pemain
func _on_Area2D_body_entered(body):
	if body.is_in_group("players"):  # Pastikan pemain berada dalam grup "players"
		target_player = body  # Set target pemain yang dikejar

func _on_Area2D_body_exited(body):
	if body.is_in_group("players"):
		target_player = null  # Hentikan pengejaran jika pemain keluar dari area
