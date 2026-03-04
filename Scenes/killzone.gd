extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.coins = 0
		get_tree().reload_current_scene()
