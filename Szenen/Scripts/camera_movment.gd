extends Node3D

@onready var camera = $Camera3D

const TARGET_ROTATION_X : float = -20.0
var target_rotation_y: float = 0.0
var turn_duration: float = 0.3

@export var cookingUI: Node
@export var rulebook: Rulebook

var directions := ["cooking", "talking", "looking", "reading"]
var current_direction := 0

func _ready() -> void:
	camera.rotation_degrees.x = TARGET_ROTATION_X
	target_rotation_y = camera.rotation.y

func _process(delta: float) -> void:
	if Input.is_action_just_released("rotate_left"):
		target_rotation_y += deg_to_rad(90)
		smooth_rotate()
		print("Rotate +")
		if directions[current_direction] == "cooking":
			cookingUI.visible = false
		if directions[current_direction] == "reading":
			rulebook.visible = false
		if current_direction == directions.size()-1:
			current_direction = 0
		else:
			current_direction += 1

	elif Input.is_action_just_released("rotate_right"):
		target_rotation_y -= deg_to_rad(90)
		smooth_rotate()
		print("Rotate -")
		if directions[current_direction] == "cooking":
			cookingUI.visible = false
		if directions[current_direction] == "reading":
			rulebook.visible = false
		if current_direction == 0:
			current_direction = directions.size()-1
		else:
			current_direction -= 1


func smooth_rotate() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(camera, "rotation:y", target_rotation_y, turn_duration)
	
