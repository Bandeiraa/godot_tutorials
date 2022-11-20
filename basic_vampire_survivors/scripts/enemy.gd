extends CharacterBody2D

@onready var sprite: Sprite2D = get_node("Texture")
@onready var collision: CollisionShape2D = get_node("Collision")

@onready var attack_timer: Timer = get_node("AttackTimer")

var previous_state: bool = false

@export var damage: int = 1
@export var health: int = 1
@export var move_speed: int = 16

func _physics_process(_delta: float) -> void:
	if global.character != null:
		move()
		
		
func move() -> void:
	var direction: Vector2 = global_position.direction_to(global.character.global_position)
	var distance: float = global_position.distance_to(global.character.global_position)
	
	if distance < 16.0:
		return
		
	velocity = direction.normalized() * move_speed
	var _move: bool = move_and_slide()
	set_orientation(direction.x)
	
	
func set_orientation(direction: float) -> void:
	if direction > 0:
		sprite.flip_h = false
		
	if direction < 0:
		sprite.flip_h = true
		
		
func update_health(_damage: int) -> void:
	health -= _damage
	if health <= 0:
		queue_free()
		
		
func set_collision_state(state: bool) -> void:
	collision.set_deferred("disabled", state)
	previous_state = state
	
	if previous_state:
		attack_timer.start(1.0)
		
		
func on_attack_timer_timeout() -> void:
	set_collision_state(not previous_state)
