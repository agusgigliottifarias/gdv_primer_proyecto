extends Area2D

const My_Dialogue = preload("res://dialogue/final.dialogue")


var is_player_close = false
var dialogue_is_active = false
@onready var excalmacion = $"Exclamación"

func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _process(delta: float) -> void:
	# Descomenté esta parte para que el diálogo funcione al presionar el botón
	if is_player_close and Input.is_action_just_pressed("ui_accept") and not dialogue_is_active:
		DialogueManager.show_dialogue_balloon(My_Dialogue, "start")


func _on_dialogue_started(dialogue):
	dialogue_is_active = true
	
func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(0.2).timeout
	dialogue_is_active = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		excalmacion.visible = true
		is_player_close = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		excalmacion.visible = false
		is_player_close = false
