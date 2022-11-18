extends KinematicBody2D

onready var sprite: Sprite = get_node("Texture")

func _ready() -> void:
	sprite.hframes = global.h_frames
	sprite.vframes = global.v_frames
	
	sprite.texture = load(global.skin_path)
