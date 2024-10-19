class_name Monster
extends CharacterBody2D

var health: int
var damage: int
var speed: float
var current_dir: String = "none"
var player_detected: bool = false
var attack_area: Area2D  # Area untuk menyerang

func _ready():
	# Mengatur atribut default untuk monster
	health = 100
	damage = 10
	speed = 70
	attack_area = $AttackArea  # Pastikan ini adalah node Area2D untuk serangan

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()  # Hapus monster saat health habis

func move_towards_player(player_position: Vector2, delta: float):
	var direction = (player_position - position).normalized()
	velocity = direction * speed
	move_and_slide()

# Fungsi untuk mendeteksi pemain
func _on_Area2D_body_entered(body: Node):
	if body.has_method("take_damage"):
		player_detected = true  # Menandakan bahwa pemain terdeteksi
		print("Player detected")

# Fungsi untuk menghandle keluar dari area deteksi
func _on_Area2D_body_exited(body: Node):
	player_detected = false  # Reset status deteksi
	print("Player exited")

func _process(delta):
	if player_detected:
		var player = get_node("res://scenes/playa.tscn")  # Ganti dengan path ke pemain
		move_towards_player(player.position, delta)

		# Periksa apakah monster berada dalam area serangan pemain
		if attack_area.get_overlapping_bodies().has(player):  # Ganti "body" dengan referensi ke objek pemain
			attack(player)

func attack(target: Node):
	if target:
		target.take_damage(damage)  # Memberikan damage yang ditentukan ke pemain
