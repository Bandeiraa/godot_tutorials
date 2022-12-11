extends KinematicBody2D

onready var jump_tween: Tween = get_node("JumpTween")

onready var texture: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")
onready var collision: CollisionShape2D = get_node("Collision")

onready var target_cell: ColorRect = get_node("TargetCell")

var on_jump: bool = false
var velocity: Vector2 = Vector2.ZERO
var target_direction: Vector2 = Vector2.RIGHT

export(float) var move_speed = 128.0

export(NodePath) onready var rock_tile = get_node(rock_tile) as TileMap
export(NodePath) onready var water_tile = get_node(water_tile) as TileMap

func _physics_process(_delta: float) -> void:
	if on_jump:
		return
		
	move()
	jump_handler()
	velocity = move_and_slide(velocity)
	
	animate()
	
	
func move() -> void:
	target_direction = get_direction()
	velocity = get_direction() * move_speed
	
	var _change_target_cell_color: bool = is_valid_cell()
	target_cell.rect_position = target_direction * 128 + Vector2(-16, -16)
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()
	
	
func jump_handler() -> void:
	if Input.is_action_just_pressed("ui_select") and not on_jump:
		interpolate_position(target_direction * 128)
		
		
func animate() -> void:
	set_direction()
	
	if on_jump:
		return
		
	if velocity != Vector2.ZERO:
		animation.play("walk")
		return
		
	animation.play("idle")
	
	
func set_direction() -> void:
	if velocity.x > 0:
		texture.flip_h = false
		
	if velocity.x < 0:
		texture.flip_h = true
		
		
func interpolate_position(direction_offset: Vector2) -> void:
	if not is_valid_cell():
		return
		
	on_jump = true
	animation.play("jump")
	
	var _jump: bool = jump_tween.interpolate_property(
		self,
		"position",
		global_position,
		global_position + direction_offset,
		0.8
	)
	
	var _start: bool = jump_tween.start()
	
	
func is_valid_cell() -> bool:
	var map_to_world: Vector2 = rock_tile.world_to_map(global_position) + target_direction * 2
	if rock_tile.get_cellv(map_to_world) != 1 and water_tile.get_cellv(map_to_world) == -1:
		target_cell.color = Color.green
		return true
		
	target_cell.color = Color.red
	return false
	
	
func on_tween_finished() -> void:
	on_jump = false
