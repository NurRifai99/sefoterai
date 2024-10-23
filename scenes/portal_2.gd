extends Area2D

var enter = false
var target_position: Vector2 = Vector2(1500, 810)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		move_player_to_target(body)
		enter = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		enter = false

func move_player_to_target(player: Node2D) -> void:
	player.position = target_position 
