extends KinematicBody2D

onready var texture: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")
onready var collision: CollisionShape2D = get_node("Collision")

var velocity: Vector2 = Vector2.ZERO

export(float) var move_speed = 128.0

func _physics_process(_delta: float) -> void:
	move()
	animate()
	
	
func move() -> void:
	velocity = get_direction() * move_speed
	velocity = move_and_slide(velocity)
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()
	
	
func animate() -> void:
	set_direction()
	
	if velocity != Vector2.ZERO:
		animation.play("walk")
		return
		
	animation.play("idle")
	
	
func set_direction() -> void:
	if velocity.x > 0:
		texture.flip_h = false
		
	if velocity.x < 0:
		texture.flip_h = true
