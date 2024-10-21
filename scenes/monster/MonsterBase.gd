extends CharacterBody2D

# Atribut dasar untuk semua monster
var health = 10
var damage = 10
var speed = 10
var attack_cooldown = 0
var target_player = null  # Referensi ke pemain yang ingin dikejar

var knockback_strength = 50  # Kekuatan knockback
var knockback_duration = 0.3  # Durasi knockback
var knockback_timer = 0.0  # Timer untuk menghitung durasi knockback
var is_knocked_back = false  # Status apakah monster sedang terkena knockback


# Fungsi untuk menerima damage
func take_damage(amount):
	health -= amount
	if health <= 0:
		die()
	
func die():
	queue_free()  # Hapus monster dari scene


func _physics_process(delta: float) -> void:
	
	# Lanjutkan dengan logika monster lainnya, seperti mengejar pemain
	if target_player:
		chase_player(delta)
# Fungsi untuk mendeteksi pemain
#func _on_Area2D_body_entered(body):
	#if body.is_in_group("players"):  # Pastikan pemain berada dalam grup "players"
		#target_player = body  # Set target pemain yang dikejar
func chase_player(_delta: float) -> void:
	var direction = (target_player.position - position).normalized()
	velocity = direction * speed
	move_and_slide()
#func _on_Area2D_body_exited(body):
	#if body.is_in_group("players"):
		#target_player = null  # Hentikan pengejaran jika pemain keluar dari area
