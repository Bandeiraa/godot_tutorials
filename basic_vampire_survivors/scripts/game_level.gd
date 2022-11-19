extends Node2D

var classes_list: Array = [
	preload("res://scenes/character/goblin.tscn"),
	preload("res://scenes/character/skeleton.tscn"),
	preload("res://scenes/character/wizard.tscn")
]

func _ready() -> void:
	randomize()
	spawn_character()
	
	
func spawn_character() -> void:
	var character = classes_list[randi() % classes_list.size()].instantiate()
	character.global_position = Vector2(640, 320)
	global.character = character
	add_child(character)
