extends Area2D

@onready var animated_sprite=$AnimatedSprite2D
@onready var collision=$CollisionShape2D
@onready var pickup_sound=$"Lost[officialMusicVideo]LinkinPark[7nkJOkuSvy]"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.add_coins()
		animated_sprite.visible=false
		collision.disabled=true
		pickup_sound.play()
		pickup_sound.finished.connect(_on_sound_finished)
		
		

func _on_sound_finished():
	queue_free()
