extends CharacterBody2D

var player_in_area = false

func _process(delta):
	pass
#func run_dialogue(dialogue_string) :
	#is_chatting = true
	#Dialogic.start(dialogue_string)
	
func _on_chatdetection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = true
		Dialogic.start("Aslan")


func _on_chatdetection_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = false
