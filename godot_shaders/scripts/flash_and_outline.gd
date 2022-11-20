extends FlashEffect

func _process(_delta: float) -> void:
	hit()
	toggle_outline()
	
	
func toggle_outline() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		material.set_shader_parameter(
			"is_outline_active",
			not material.get_shader_parameter("is_outline_active")
		)
