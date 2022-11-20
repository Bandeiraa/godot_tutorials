extends Sprite2D
class_name FlashEffect

@onready var hit_timer: Timer = get_node("HitTimer")

var on_hit: bool = false

func _process(_delta: float) -> void:
	hit()
	
	
func hit() -> void:
	if Input.is_action_just_pressed("ui_select") and not on_hit:
		material.set_shader_parameter("is_on_hit", true)
		hit_timer.start(0.3)
		on_hit = true
		
		
func on_hit_timer_timeout() -> void:
	on_hit = false
	material.set_shader_parameter("is_on_hit", false)
