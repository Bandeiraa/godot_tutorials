extends Sprite2D

@onready var animation: AnimationPlayer = get_node("Animation")

var on_hit: bool = false

func _process(_delta: float) -> void:
	hit()
	toggle_outline()
	
	
func hit() -> void:
	#Espaço do teclado
	if Input.is_action_just_pressed("ui_select") and not on_hit:
		animation.play("hit")
		on_hit = true
		
		
func toggle_outline() -> void:
	#Enter do teclado
	if Input.is_action_just_pressed("ui_accept"):
		material.set_shader_parameter(
			"is_outline_active",
			not material.get_shader_parameter("is_outline_active")
		)
		
		
func on_animation_finished(anim_name: String) -> void:
	if anim_name == "hit":
		on_hit = false
		animation.play("idle")
		material.set_shader_parameter("is_on_hit", false)
