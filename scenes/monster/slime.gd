extends "res://scenes/monster/Monsterbase.gd"

# Waktu cooldown antara serangan
var can_attack = true
var player_in_range = false

func _ready() -> void:
	health = 50
	damage = 10
	speed = 20
	attack_cooldown = 0.7 
	
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	if target_player:  # Jika ada target pemain
		chase_player(delta)
		if player_in_range and can_attack:
			attack_player()
	else:
		velocity = Vector2.ZERO  # Tidak bergerak jika tidak ada target

# Fungsi untuk mengejar pemain
func chase_player(_delta: float) -> void:
	var direction = (target_player.position - position).normalized()
	velocity = direction * speed
	$AnimatedSprite2D.play("walk")
	move_and_slide()

# Fungsi untuk menyerang pemain
func attack_player() -> void:
	can_attack = false  # Nonaktifkan serangan selama cooldown
	target_player.take_damage(damage)  # Serang pemain
	$AnimatedSprite2D.play("attack")
	print("player attacked ", damage)  
	# Reset cooldown
	await get_tree().create_timer(attack_cooldown).timeout  # Tunggu cooldown selesai
	can_attack = true  # Aktifkan serangan lagi

# Fungsi
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):  # Pastikan pemain di dalam grup "player"
		target_player = body  # Simpan referensi ke pemain

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):  # Pastikan body yang keluar adalah pemain
		target_player = null  # Hapus referensi ke pemain
		$AnimatedSprite2D.play("idle")  # Kembali ke animasi idle
		velocity = Vector2.ZERO  # Set velocity ke nol agar slime berhenti bergerak

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and can_attack:
		player_in_range = true
		
func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") :
		player_in_range = false
