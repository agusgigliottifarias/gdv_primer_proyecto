extends CharacterBody2D

const SPEED = 125.0
const JUMP_VELOCITY = -225.0

# 1. Primero ponemos todas las variables juntas arriba
@onready var anim = $Sprite2D
@onready var hud = get_node("/root/Map/CanvasLayer")
##@onready var jump_sound = $AudioStreamPlayer2D

# 2. Luego las funciones personalizadas
func add_coins():
	Global.coins += 1
	hud.set_coins(Global.coins)

# 3. Y por último las funciones nativas de Godot como el _physics_process
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("saltar") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		##jump_sound.play()

	# Movimiento
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		anim.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Animaciones
	if not is_on_floor() and velocity.y < 0:
		anim.play("Jump")
	elif direction != 0:
		anim.play("Walk")
	else:
		anim.play("Idle")
