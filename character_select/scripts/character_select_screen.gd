extends Control

onready var main_text: Label = get_node("VContainer/MainText")
onready var h_container: HBoxContainer = get_node("VContainer/HContainer")

onready var left_container: VBoxContainer = get_node("VContainer/HContainer/LeftButton")
onready var right_container: VBoxContainer = get_node("VContainer/HContainer/RightButton")
onready var select_container: HBoxContainer = get_node("VContainer/SelectContainer")

onready var objects_list: Array = [
	get_node("VContainer/HContainer/Archer"),
	get_node("VContainer/HContainer/Pawn"),
	get_node("VContainer/HContainer/Warrior")
]

var path_list: Array = [
	"res://assets/troops/archer/",
	"res://assets/troops/pawn/",
	"res://assets/troops/warrior/"
]

var colors_list: Array = [
	"blue",
	"purple",
	"red",
	"yellow"
]

var selected_object: Sprite = null

var class_id: int = -1
var skin_index: int = 0
var is_class_selected: bool = false

func _ready() -> void:
	for button in get_tree().get_nodes_in_group("button"):
		button.connect("pressed", self, "on_button_pressed", [button])
		button.connect("mouse_exited", self, "mouse_interaction", [button, "exited"])
		button.connect("mouse_entered", self, "mouse_interaction", [button, "entered"])
		
		
func mouse_interaction(button: Button, state: String) -> void:
	if button.name == "Previous" or button.name == "Next" or button.name == "StartGame" or not is_class_selected:
		match state:
			"exited":
				button.modulate.a = 1.0
				
			"entered":
				button.modulate.a = 0.5
				
				
func on_button_pressed(button: Button) -> void:
	change_object_visibility(button)
	
	
func change_object_visibility(object: Button) -> void:
	if object.name == "StartGame":
		var _change_scene: bool = get_tree().change_scene("res://scenes/character.tscn")
		return
		
	if object.name == "Previous":
		update_index("decrease")
		update_skin()
		return
		
	if object.name == "Next":
		update_index("increase")
		update_skin()
		return
		
	is_class_selected = true
	
	for _object in objects_list:
		if not object == _object:
			_object.hide()
			
	object.modulate.a = 1.0
	class_id = objects_list.find(object)
	selected_object = object.get_node("Texture")
	
	left_container.show()
	right_container.show()
	select_container.show()
	main_text.text = "Please, select a skin color"
	
	
func update_index(type: String) -> void:
	if type == "decrease":
		skin_index -= 1
		
	if type == "increase":
		skin_index += 1
		
	if skin_index == -1:
		skin_index = colors_list.size() - 1
		
	if skin_index == colors_list.size():
		skin_index = 0
		
		
func update_skin() -> void:
	selected_object.texture = load(
		path_list[class_id] + colors_list[skin_index] + ".png"
	)
	
	global.h_frames = selected_object.hframes
	global.v_frames = selected_object.vframes
	global.skin_path = path_list[class_id] + colors_list[skin_index] + ".png"
