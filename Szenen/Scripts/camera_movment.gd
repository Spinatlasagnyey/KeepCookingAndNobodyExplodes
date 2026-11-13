extends Node3D

@onready var camera = $Camera3D
var target_rotation_y: float = 0.0
var turn_duration: float = 0.3

func _process(delta: float) -> void:
	if Input.is_action_just_released("rotate_left"):
		target_rotation_y += deg_to_rad(90)
		smooth_rotate()
		print("Rotate +")
	elif Input.is_action_just_released("rotate_right"):
		target_rotation_y -= deg_to_rad(90)
		smooth_rotate()
		print("Rotate -")

func smooth_rotate() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(camera, "rotation:y", target_rotation_y, turn_duration)
