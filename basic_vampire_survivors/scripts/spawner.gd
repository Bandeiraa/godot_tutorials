extends Node2D

@onready var timer: Timer = get_node("Timer")
@onready var spawner_list: Node2D = get_node("SpawnerList")

var enemies_list: Dictionary = {
	"abomination": {
		"spawn_probability": [
			1,
			45
		],
		
		"scene_path": preload("res://scenes/enemies/abomination.tscn")
	},
	
	"deadly_turtle": {
		"spawn_probability": [
			45,
			70
		],
		
		"scene_path": preload("res://scenes/enemies/deadly_turtle.tscn")
	},
	
	"dragon": {
		"spawn_probability": [
			70,
			80
		],
		
		"scene_path": preload("res://scenes/enemies/dragon.tscn")
	},
	
	"flying_eye": {
		"spawn_probability": [
			80,
			85
		],
		
		"scene_path": preload("res://scenes/enemies/flying_eye.tscn")
	},
	
	"slime": {
		"spawn_probability": [
			85,
			90
		],
		
		"scene_path": preload("res://scenes/enemies/slime.tscn")
	},
	
	"spider": {
		"spawn_probability": [
			90,
			95
		],
		
		"scene_path": preload("res://scenes/enemies/spider.tscn")
	},
	
	"wasp": {
		"spawn_probability": [
			95,
			99
		],
		
		"scene_path": preload("res://scenes/enemies/wasp.tscn")
	}
}

func _ready() -> void:
	randomize()
	
	
func _process(_delta: float) -> void:
	if global.character != null:
		global_position = global.character.global_position
		
		
func spawn_enemy():
	var random_number: int = randi() % 100 + 1
	var spawners: Array = spawner_list.get_children()
	
	for key in enemies_list.keys():
		if (
			random_number >= enemies_list[key].spawn_probability[0] and 
			random_number < enemies_list[key].spawn_probability[1]
		):
			var enemy = enemies_list[key].scene_path.instantiate()
			enemy.global_position = spawners[randi() % spawners.size()].global_position
			get_parent().add_child(enemy)
			
			
func on_timer_timeout() -> void:
	timer.start()
	spawn_enemy()
