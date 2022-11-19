extends Area2D

@onready var animation: AnimationPlayer = get_node("Animation")

@export var move_speed: float = 48.0

func _physics_process(delta: float) -> void:
	move(delta)
	if get_direction() != Vector2.ZERO:
		animation.play("walk")
		return
		
	animation.play("idle")
	
	
func move(delta: float) -> void:
	position += get_direction() * move_speed * delta
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()
