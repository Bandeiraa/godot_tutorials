extends Area2D

@onready var sprite: Sprite2D = get_node("Texture")
@onready var animation: AnimationPlayer = get_node("Animation")

@onready var attack_timer: Timer = get_node("AttackCooldown")

var can_attack: bool = true

@export var health: int = 1
@export var move_speed: float = 48.0
@export var attack_cooldown: float = 1.5

@export var attack: PackedScene

func _physics_process(delta: float) -> void:
	move(delta)
	set_orientation(get_direction().x)
	
	if Input.is_action_just_pressed("ui_attack") and can_attack:
		spawn_attack()
		
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
	
	
func set_orientation(direction: float) -> void:
	if direction > 0:
		sprite.flip_h = false
		
	if direction < 0:
		sprite.flip_h = true
		
		
func spawn_attack() -> void:
	attack_timer.start(attack_cooldown)
	var _attack = attack.instantiate()
	
	_attack.global_position = global_position
	_attack.direction = global_position.direction_to(get_global_mouse_position()).normalized()
	
	get_parent().call_deferred("add_child", _attack)
	
	can_attack = false
	
	
func on_attack_cooldown_timeout() -> void:
	can_attack = true
	
	
func on_body_entered(body) -> void:
	if body.is_in_group("enemy"):
		update_health(body.damage)
		body.set_collision_state(true)
		
		
func update_health(damage: int) -> void:
	health -= damage
	if health <= 0:
		var _reload: bool = get_tree().reload_current_scene()
