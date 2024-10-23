extends "res://scenes/monster/MonsterBase.gd"

var can_attack = true
var player_in_range = false

func _ready() -> void:
	health = 50
	damage = 10
	speed = 20
	
	attack_cooldown = 0.7
	#target_player = null  # Referensi ke pemain yang ingin dikejar
	$AnimatedSprite2D.play("first")

func _physics_process(delta: float) -> void:
	if is_knocked_back:
		knockback_timer -= delta
		if knockback_timer <= 0:
			is_knocked_back = false  # Reset status knockback
			velocity = Vector2.ZERO  # Set kecepatan ke nol setelah knockback
		move_and_slide()  # Bergerak dengan kecepatan knockback
		return  # Keluar dari fungsi jika sedang knockback
	
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
	
	if(target_player.position.x - position.x) < 0:
		$AnimatedSprite2D.flip_h = true
	elif(target_player.position.x - position.x) > 0:
		$AnimatedSprite2D.flip_h = false

# Fungsi untuk menyerang pemain
func attack_player() -> void:
	can_attack = false  # Nonaktifkan serangan selama cooldown
	target_player.take_damage(damage)  # Serang pemain
	
	$AnimatedSprite2D.play("attack")
	print("sernag")
	print("menyerang player",damage)
	# Reset cooldown
	await get_tree().create_timer(attack_cooldown).timeout  # Tunggu cooldown selesai
	can_attack = true  # Aktifkan serangan lagi

# Fungsi untuk menerima damage
func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()
	else:
		# Menghitung arah knockback jika target_player ada
		if target_player:
			var direction = (position - target_player.position).normalized()
			velocity = direction * knockback_strength  # Arah knockback
			is_knocked_back = true  # Set status knockback
			knockback_timer = knockback_duration  # Reset timer knockback

# Fungsi untuk mati
func die() -> void:
	print("Slime has been killed")
	$AnimatedSprite2D.play("die")
	queue_free()  # Hapus slime dari scene

# Fungsi untuk mendeteksi pemain
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):  # Pastikan pemain di dalam grup "player"
		$AnimatedSprite2D.play("transform")
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
	if body.is_in_group("player"):
		player_in_range = false

func _on_animated_sprite_2d_animation_finished() -> void:
	pass # Replace with function body.
