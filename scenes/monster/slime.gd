extends "res://scenes/monster/Monsterbase.gd"

# Atribut untuk serangan
var attack_damage = 5
var attack_cooldown = 1.5  # Waktu cooldown antara serangan
var can_attack = true

func _ready() -> void:
	health = 50
	damage = 10
	speed = 20
	
	$AnimatedSprite2D.play("idle")
	# Memuat sprite dan animasi slime
	#$AnimatedSprite2D.frames = preload("res://path/to/slime_spritesheet.tres")
	#$AnimatedSprite2D.play("idle")

# Fungsi untuk menyerang pemain
func _physics_process(delta: float) -> void:
	if target_player:
		chase_player(delta)
		if can_attack and position.distance_to(target_player.position) < 50:  # Jarak serangan
			await attack_player()  # Ubah ke await untuk memanggil fungsi serangan
	else:
		velocity = Vector2.ZERO  # Tidak bergerak jika tidak ada target

# Fungsi untuk mengejar pemain
func chase_player(delta: float) -> void:
	var direction = (target_player.position - position).normalized()
	velocity = direction * speed
	move_and_slide()

# Fungsi untuk menyerang pemain
func attack_player() -> void:
	can_attack = false  # Nonaktifkan serangan selama cooldown
	target_player.take_damage(attack_damage)  # Serang pemain
	$AnimatedSprite2D.play("walk")  # Mainkan animasi serangan (pastikan ada animasi ini)
	# Reset cooldown
	await get_tree().create_timer(attack_cooldown).timeout  # Tunggu cooldown selesai
	can_attack = true  # Aktifkan serangan lagi

# Fungsi untuk menerima damage
func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()

# Fungsi untuk mati
func die() -> void:
	queue_free()  # Hapus slime dari scene


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):  # Pastikan pemain di dalam grup "player"
			target_player = body 


 #Replace with function body.
