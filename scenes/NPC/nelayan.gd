extends CharacterBody2D

<<<<<<< HEAD
var player_in_area = false

func _process(delta):
	pass
#func run_dialogue(dialogue_string) :
	#is_chatting = true
	#Dialogic.start(dialogue_string)
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = true
		Dialogic.start("Nelayan")
		print("damn")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = false
=======

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _ready() -> void:
	$AnimatedSprite2D.play("idle")

#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
>>>>>>> 5ed8c84aca1f9a5d55b13ab00f6c37af6e1bd316
