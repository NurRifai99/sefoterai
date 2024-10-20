extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 150
var player_alive = true

var attack_ip = false  # Indicates if attack is in progress

const speed = 70
var current_dir = "none"
var attack_duration = 0.5  # Duration of attack animation in seconds
var attack_timer = 0.0  # Timer to track attack progress

func _physics_process(delta):
	player_movement(delta)
	
	# Handle attack cooldown and animation timing
	if attack_ip:
		attack_timer -= delta
		if attack_timer <= 0:
			attack_ip = false  # End the attack
			attack_timer = 0.0
	
	if health <= 0:
		player_alive = false
		health = 0
		print("Player has been killed")
		#self.queue_free()
		get_tree().change_scene_to_file("res://scenes/Menu.tscn")
	
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
	if event.is_action_pressed("attack") and not attack_ip:  # If attack button is pressed and no attack is in progress
		attack_ip = true
		attack_timer = attack_duration  # Set attack duration
		play_anim(2)  # Trigger attack animation

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

func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		player_alive = false
		print("Player has been killed")
		self.queue_free()  # Remove player from the scene

func _on_attack_area_body_entered(body: Node2D) -> void:
	pass  # Replace with function body.
