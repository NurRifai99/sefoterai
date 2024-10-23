extends "res://scenes/monster/MonsterBase.gd"

var can_attack = true
var player_in_range = false
var max_health: int = 50
var healthbar: ProgressBar

func _ready() -> void:
	health = 50
	damage = 10
	speed = 10
	healthbar = $healthbar
	healthbar.max_value = max_health
	attack_cooldown = 0.7
	
	var signal_callable = Callable(self, "_on_cooldown_timeout")
	#target_player = null  # Referensi ke pemain yang ingin dikejar
	$AnimatedSprite2D.play("idle")
	if not $Timer.is_connected("timeout", signal_callable):
		$Timer.connect("timeout", signal_callable)


func _physics_process(delta: float) -> void:
	update_health()
	
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
func chase_player(delta: float) -> void:
		position += (target_player.position - position).normalized() * speed * delta
		move_and_collide(Vector2(0,0)) 
		$AnimatedSprite2D.play("walk")
		if(target_player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false


# Fungsi untuk menyerang pemain
func attack_player() -> void:
	if can_attack:
		can_attack = false  # Nonaktifkan serangan selama cooldown
		target_player.take_damage(damage)  # Serang pemain
		$AnimatedSprite2D.play("attack")
		print("player attacked ", damage)  
		# Reset cooldown
		$Timer.start(attack_cooldown)


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

func update_health():
	healthbar.value = health
	healthbar.visible = true

# Fungsi untuk mati
func die() -> void:
	print("Slime has been killed")
	$AnimatedSprite2D.play("die")
	queue_free()  # Hapus slime dari scene
	get_parent().current_slime -= 1	
	print("currens slime ",get_parent().current_slime)
	
	if get_parent().current_slime == 0:
		get_parent().start_respawn()

# Fungsi untuk mendeteksi pemain
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
	if body.is_in_group("player"):
		player_in_range = false


func _on_timer_timeout() -> void:
	can_attack = true   # Replace with function body.

#
