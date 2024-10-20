extends CharacterBody2D

# Atribut dasar untuk semua monster
var health = 100
var damage = 10
var speed = 50
var attack_cooldown = 0
var target_player = null  # Referensi ke pemain yang ingin dikejar


# Fungsi untuk menerima damage
func take_damage(amount):
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()  # Hapus monster dari scene

# Fungsi untuk mendeteksi pemain
#func _on_Area2D_body_entered(body):
	#if body.is_in_group("players"):  # Pastikan pemain berada dalam grup "players"
		#target_player = body  # Set target pemain yang dikejar
#
#func _on_Area2D_body_exited(body):
	#if body.is_in_group("players"):
		#target_player = null  # Hentikan pengejaran jika pemain keluar dari area
