extends StaticBody3D

@onready var audioPlayer: AudioStreamPlayer3D = $AudioStreamPlayer3DRadio
@onready var dialogue_system: DialogueManager = %DialogueSystem

@export var alertSound: AudioStream 
@export var dialogue_collection: DialogueCollection

var dialogue_queue : Array[DialogueResource]

func _ready() -> void:
	EventManager.dialogue_alert.connect(_on_dialogue_alert)

func _input_event(
	_camera: Camera3D,
	event: InputEvent,
	_event_position: Vector3,
	_normal: Vector3,
	_shape_idx: int
) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			play_dialogue()

func play_dialogue() -> bool:
	if dialogue_queue.is_empty():
		push_warning("dialogue queue was empty and tried to be played")
		return false
	var dialogue: DialogueResource = dialogue_queue.front()

	dialogue_system.start_dialogue(self, dialogue) 
	return true

func play_alert():
	audioPlayer.stream = alertSound
	audioPlayer.play()
	
func _on_dialogue_alert(dialogue : DialogueResource):
	dialogue_queue.append(dialogue)
	play_alert()
