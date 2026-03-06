extends Area2D

@onready var pickup_sound=$"MarioBrosMoneda(soundEffect)[bxX4BtTrsU]"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		
		get_tree().change_scene_to_file("res://Scenes/Escena_final.tscn")
