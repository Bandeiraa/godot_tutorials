extends CanvasModulate

onready var animation = get_node("Animation")

func _process(_delta: float) -> void:
	var time = OS.get_time()
	var time_in_seconds: int = time.hour * 3600 + time.minute * 60 + time.second
	var current_frame = range_lerp(time_in_seconds, 0, 86400, 0, 24)
	animation.play("day_and_night")
	animation.seek(current_frame)
