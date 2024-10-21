extends CharacterBody2D

var health = 200
var player_alive = true
var damage_player = 20

var target_monster: Node2D = null  # Untuk menyimpan monster yang berada dalam jangkauan

var attack_ip = false  # Menunjukkan jika serangan sedang berlangsung

const speed = 70
var current_dir = "none"
var attack_timer = 0.0  # Timer untuk melacak progres serangan

#func _ready() -> void:
	#$AttackArea.connect("body_entered",Callable(self, "_on_attack_area_body_entered"))

func _physics_process(delta):
	player_movement(delta)
	
	if attack_ip:
		attack_timer -= delta
		if attack_timer <= 0:
			attack_ip = false  # End the attack
			attack_timer = 0.0
	
	if health <= 0:
		player_alive = false
		health = 0
		print("Player has been killed")
		#get_tree().change_scene_to_file("res://scenes/Menu.tscn")

func player_movement(_delta):
	# Disable movement during attack
	if attack_ip:
		play_anim(2)  # Play attack animation
		return
	
	velocity = Vector2.ZERO  # Reset velocity each frame
	
	if Input.is_action_pressed("move_right"):
		current_dir = "right"
		velocity.x += speed
	elif Input.is_action_pressed("move_left"):
		current_dir = "left"
		velocity.x -= speed

	if Input.is_action_pressed("move_down"):
		current_dir = "down"
		velocity.y += speed
	elif Input.is_action_pressed("move_up"):
		current_dir = "up"
		velocity.y -= speed

	# Normalize the velocity to prevent faster diagonal movement
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		play_anim(1)
	else:
		play_anim(0)

	move_and_slide()

# Handle attack input
func _input(event):
	if event.is_action_pressed("attack") and not attack_ip:  # Jika tombol serang ditekan dan tidak sedang menyerang
		attack_ip = true
		attack_timer = 0.4  # Durasi serangan
		play_anim(2)  # Mainkan animasi serangan

		if target_monster:  # Jika ada monster dalam jangkauan
			attack_monster(target_monster)  # Serang monster yang terdeteksi
			print("Attacking the monster!")


func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if attack_ip:  # If attack is in progress, play attack animation based on direction
		if dir == "right":
			anim.flip_h = false
			anim.play("side_attack")
		elif dir == "left":
			anim.flip_h = true
			anim.play("side_attack")
		elif dir == "up":
			anim.play("back_attack")
		elif dir == "down":
			anim.play("front_attack")
		return  # Exit the function to avoid playing walk/idle animations

	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
			
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	
	if dir == "up":
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
	
	if dir == "down":
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
			
func attack_monster(monster: Node2D):
	if not attack_ip:
		return  # Jika tidak sedang menyerang, keluar dari fungsi

	monster.take_damage(damage_player)  # Berikan damage ke monster
	print("Player attacked the monster for ", damage_player, " damage!")


func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		player_alive = false
		print("Player has been killed")
		get_tree().change_scene_to_file("res://scenes/MenuRestart.tscn")
		#self.queue_free()  # Remove player from the scene

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("monster"):  # Pastikan yang terkena serangan adalah monster
		target_monster = body  # Simpan referensi ke monster
		print("Monster in range!")

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("monster"):
		target_monster = null  # Hapus referensi ke monster
		print("Monster out of range.")
