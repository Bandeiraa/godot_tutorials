extends Button

@onready var label: Label = get_node("Text")

var target_scene_path: String = ""

func update_button_text(button_text: String) -> void:
	label.text = button_text
	
	
func on_button_pressed():
	var _change_scene: bool = get_tree().change_scene_to_file(target_scene_path)
