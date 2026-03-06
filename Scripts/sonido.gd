extends Area2D


@onready var pickup_sound=$GdvArpeggio

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		pickup_sound.play()
		pickup_sound.finished.connect(_on_sound_finished)
		


func _on_sound_finished():
	queue_free()
