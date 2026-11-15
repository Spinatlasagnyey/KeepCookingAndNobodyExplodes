extends StaticBody3D

func _input_event(camera: Camera3D, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			$"../CanvasLayer/CookingUI".cook()

func _on_mouse_entered() -> void:
	$"../CanvasLayer/CookSign".visible = true

func _on_mouse_exited() -> void:
	$"../CanvasLayer/CookSign".visible = false
