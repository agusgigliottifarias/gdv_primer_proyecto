extends CanvasLayer

@export var main_scene: PackedScene

func _on_menu_button_pressed() -> void:
	# get_tree().change_scene_to_file("res://Scenes/Map.scn")
	get_tree().change_scene_to_packed(main_scene)
