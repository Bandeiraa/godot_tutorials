extends Control

enum list_info {
	NAME,
	SCENE
}

const SHADER_BUTTON: PackedScene = preload("res://scenes/management/shader_button.tscn")

@onready var v_container: VBoxContainer = get_node("VContainer/ShaderList/VContainer")

var shader_list: Array = [
	[
		"Contorno",
		"res://scenes/outline_2d.tscn"
	],
	
	[
		"Efeito de Hit/Flash",
		"res://scenes/flash_effect.tscn"
	],
	
	[
		"Hit/Flash + Contorno",
		"res://scenes/flash_and_outline.tscn"
	],
	
	[
		"Dissolver",
		"res://scenes/dissolve.tscn"
	]
]

func _ready() -> void:
	for shader in shader_list:
		spawn_shader_button(shader)
		
		
func spawn_shader_button(shader: Array) -> void:
	var button = SHADER_BUTTON.instantiate()
	
	v_container.add_child(button)
	button.target_scene_path = shader[list_info.SCENE]
	button.update_button_text(shader[list_info.NAME])
