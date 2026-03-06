extends Area2D

@onready var animated_sprite=$AnimatedSprite2D
@onready var collision=$CollisionShape2D
@onready var pickup_sound=$"MarioBrosMoneda(soundEffect)[bxX4BtTrsU]"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.add_coins()
		animated_sprite.visible = false
		collision.set_deferred("disabled", true)
		
		pickup_sound.play()
		await pickup_sound.finished # El código se "pausa" aquí hasta que el sonido termina
		queue_free() # Al terminar el sonido, se ejecuta esta línea
