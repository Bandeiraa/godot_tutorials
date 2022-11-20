extends Area2D

@onready var sprite: AnimatedSprite2D = get_node("Sprite")

var direction: Vector2

@export var can_rotate: bool = true

@export var damage: int = 1
@export var move_speed: int = 192

func _ready() -> void:
	sprite.play()
	if can_rotate:
		rotation = direction.angle()
		
		
func _physics_process(delta: float) -> void:
	translate(move_speed * delta * direction)
	
	if not can_rotate:
		rotation += 6 * delta
		
		
func on_body_entered(body) -> void:
	if body.is_in_group("enemy"):
		body.update_health(damage)
		
		
func on_screen_exited() -> void:
	queue_free()
