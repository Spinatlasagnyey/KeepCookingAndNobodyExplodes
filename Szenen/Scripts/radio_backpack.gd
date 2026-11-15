extends Node3D

@onready var audioPlayer: AudioStreamPlayer3D = %AudioStreamPlayer3DRadio
 
@export var alertSound: AudioStream 

var dialogue_system: DialogueManager
var dialogue_queue : Array[DialogueResource]

func _ready() -> void:
	EventManager.dialogue_alert.connect(_on_dialogue_alert)
	dialogue_system = get_tree().get_first_node_in_group("dialogue_manager")
	if dialogue_system == null:
		push_warning("Backpack: dialogueSystem not found!")
	else:
		print(dialogue_system)

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


func _on_static_body_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		print("input event mouse button")
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			play_dialogue()
