extends StaticBody3D

@onready var audioPlayer: AudioStreamPlayer3D = $AudioStreamPlayer3DRadio

@export var alertSound: AudioStream 
@export var dialogue_collection: DialogueCollection

func _input_event(
	_camera: Camera3D,
	event: InputEvent,
	_event_position: Vector3,
	_normal: Vector3,
	_shape_idx: int
) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dialogue_collection.play_dialogue("first_contact", self)

func play_alert():
	audioPlayer.stream = alertSound
	audioPlayer.play()
