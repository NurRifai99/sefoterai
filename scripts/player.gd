extends CharacterBody2D

var attack_ip = false
var health = 100  
var damage = 20   
var speed = 75  
var current_dir = "none" 



# Untuk mendeteksi monster dalam area serangan
@onready var attack_area = $AttackArea  # Pastikan ini adalah node Area2D yang ada di scene

func _physics_process(delta):
	player_movement(delta)

	if health <= 0:
		print("Player has been killed")
		queue_free()  # Hapus pemain dari scene jika health habis

	# Jika pemain menyerang
	if Input.is_action_just_pressed("attack"):
		print("attack")
		perform_attack()

func player_movement(_delta):
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

	# Normalisasi kecepatan untuk mencegah pergerakan diagonal yang lebih cepat
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		play_anim(1)
	else:
		play_anim(0)

	move_and_slide()

func play_anim(movement):
	var anim = $AnimatedSprite2D

	if current_dir == "right":
		anim.flip_h = false
		anim.play("side_walk" if movement == 1 else "side_idle")
	elif current_dir == "left":
		anim.flip_h = true
		anim.play("side_walk" if movement == 1 else "side_idle")
	elif current_dir == "up":
		anim.play("back_walk" if movement == 1 else "back_idle")
	elif current_dir == "down": 
		anim.play("front_walk" if movement == 1 else "front_idle")

# Fungsi untuk melakukan serangan
func perform_attack():
	var dir = current_dir
	
	var animasi = $AnimatedSprite2D
	if dir == "right":
		animasi.flip_h = false
		animasi.play("side_attack")
	elif dir == "left":
		animasi.flip_h = true
		animasi.play("side_attack")
	elif dir == "up":
		animasi.play("back_attack")
	elif dir == "down":
		animasi.play("front_attack")
	
	attack_ip = true  # Menandakan bahwa pemain sedang menyerang
	
	#Pastikan ada animasi serangan

	# Mendapatkan semua monster dalam area serangan
	for body in attack_area.get_overlapping_bodies():
		if body.is_in_group("monster") and body.has_method("take_damage"):
			attack(body)

func attack(target: Node):
	if target:
		target.take_damage(damage)  # Memberikan damage yang ditentukan ke monster

func take_damage(amount: int):
	health -= amount  # Mengurangi health pemain
	if health <= 0:
		queue_free()  # Hapus pemain dari scene jika health habis
 

func _on_attack_area_body_entered(_body: Node2D) -> void:
	pass # Replace with function body
