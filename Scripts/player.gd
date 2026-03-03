extends CharacterBody2D


const SPEED = 125.0
const JUMP_VELOCITY = -225.0

@onready var anim = $Sprite2D

var coins =0
@onready var hud = get_node("/root/Map/CanvasLayer")

@onready var jump_sound=$AudioStreamPlayer2D

func add_coins():
	coins +=1
	hud.set_coins(coins)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("saltar") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	##var direction := 0 # := Input.get_axis("ui_left", "ui_right")
	#if Input.is_action_pressed("ui_right"):
		#direction += 1
		#
	  #if Input.is_action_pressed("ui_left"):
		#direction -= 1
				   #
	#
	#if direction:
		#velocity.x = direction * SPEED
		#anim.flip_h=direction<0
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		anim.flip_h=direction<0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


	if not is_on_floor() && velocity.y<0:
		anim.play("Jump")
	elif direction !=0:
		anim.play("Walk")
	else:
		anim.play("Idle")
