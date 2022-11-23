extends Sprite2D

@onready var animation: AnimationPlayer = get_node("Animation")

var can_apply_shader: bool = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_select") and can_apply_shader:
		interpolate(0.0)
		can_apply_shader = false
		
		
func interpolate(value: float) -> void:
	var tween: Tween = create_tween()
	var _interpolate: PropertyTweener = tween.tween_property(
		material,
		"shader_parameter/dissolve_range",
		value,
		0.5
	)
	
	animation.play("dissolve")
	
	
func on_animation_finished(anim_name: String) -> void:
	if anim_name == "dissolve":
		interpolate(1.0)
		can_apply_shader = true
		animation.play("reverse_dissolve")
		
	if anim_name == "reverse_dissolve":
		animation.play("idle")
