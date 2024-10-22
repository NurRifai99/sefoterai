extends "res://scenes/monster/MonsterBase.gd"

var can_attack = true
var player_in_range = false
<<<<<<< HEAD
=======
var max_health: int = 500
var healthbar: ProgressBar
>>>>>>> 2f600d1 (health bar)

func _ready() -> void:
	health = 500
	damage = 30
	speed = 30
<<<<<<< HEAD
	
	
	attack_cooldown = 1
	#target_player = null  # Referensi ke pemain yang ingin dikejar
	$AnimatedSprite2D.play("idle")
	$Timer.connect("timeout", Callable(self,"_on_cooldown_timeout"))

func _physics_process(delta: float) -> void:
	
	#fungsi knockback
=======
	healthbar = $healthbar
	healthbar.max_value = max_health
	attack_cooldown = 1
	var signal_callable = Callable(self, "_on_cooldown_timeout")
	if not $Timer.is_connected("timeout", signal_callable):
		$Timer.connect("timeout", signal_callable)
	
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	update_health()

>>>>>>> 2f600d1 (health bar)
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
<<<<<<< HEAD
=======
	
	if(target_player.position.x - position.x) < 0:
		$AnimatedSprite2D.flip_h = true
	elif(target_player.position.x - position.x) > 0:
		$AnimatedSprite2D.flip_h = false
>>>>>>> 2f600d1 (health bar)

# Fungsi untuk menyerang pemain
func attack_player() -> void:
	if can_attack:
<<<<<<< HEAD
 # Nonaktifkan serangan selama cooldown
		$AnimatedSprite2D.play("attack")
		target_player.take_damage(damage)  # Serang pemain
		print("player attacked ", damage)  
		# Reset cooldown
		can_attack = false 
		$Timer.start(attack_cooldown)

=======
		can_attack = false  # Nonaktifkan serangan selama cooldown
		target_player.take_damage(damage)  # Serang pemain
		$AnimatedSprite2D.speed_scale = 0.1  # Set slower speed for attack
		$AnimatedSprite2D.frame = 0  # Reset to frame 0 to ensure it starts fresh
		$AnimatedSprite2D.play("attack")
		print("Attack animation speed: ", $AnimatedSprite2D.speed_scale)
		print("player attacked ", damage)  
		# Reset cooldown
		$Timer.start(attack_cooldown)


>>>>>>> 2f600d1 (health bar)
# Fungsi untuk menerima damage
func take_damage(amount: int) -> void:
	health -= amount
	$AnimatedSprite2D.play("take_damage")
	if health <= 0:
		die()
	else:
		# Menghitung arah knockback jika target_player ada
		if target_player:
			var direction = (position - target_player.position).normalized()
			velocity = direction * knockback_strength  # Arah knockback
			is_knocked_back = true  # Set status knockback
			knockback_timer = knockback_duration  # Reset timer knockback

<<<<<<< HEAD
# Fungsi untuk mati
func die() -> void:
	print("Slime has been killed")
	$AnimatedSprite2D.play("die")
	queue_free() 
=======
func update_health():
	healthbar.value = health
	healthbar.visible = true

func die() -> void:
	print("Red Samurai has been killed")
	queue_free()  # Hapus slime dari scene
>>>>>>> 2f600d1 (health bar)

# Fungsi untuk mendeteksi pemain
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):  # Pastikan pemain di dalam grup "player"
		target_player = body  # Simpan referensi ke pemain

func _on_area_2d_body_exited(body: Node2D) -> void:
<<<<<<< HEAD
	if body.is_in_group("player"):  # Pastikan body yang keluar adalah pemain
=======
	if body.is_in_group("player"):  # Pastikan body yang keluar adalah adsda
>>>>>>> 2f600d1 (health bar)
		target_player = null  # Hapus referensi ke pemain
		$AnimatedSprite2D.play("idle")  # Kembali ke animasi idle
		velocity = Vector2.ZERO  # Set velocity ke nol agar slime berhenti bergerak

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and can_attack:
		player_in_range = true

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false


func _on_cooldown_timeout() -> void:
	can_attack = true  # Aktifkan serangan lagi
