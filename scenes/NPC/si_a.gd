extends CharacterBody2D

var player_in_area = false
<<<<<<< HEAD
=======
var is_chatting = false
>>>>>>> 5ed8c84aca1f9a5d55b13ab00f6c37af6e1bd316

func _process(delta):
	pass
#func run_dialogue(dialogue_string) :
	#is_chatting = true
	#Dialogic.start(dialogue_string)
	
func _on_chatdetection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = true
<<<<<<< HEAD
		Dialogic.start("Aslan")
=======
		Dialogic.start("timeline si A")
		print("komntol")
>>>>>>> 5ed8c84aca1f9a5d55b13ab00f6c37af6e1bd316


func _on_chatdetection_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = false
