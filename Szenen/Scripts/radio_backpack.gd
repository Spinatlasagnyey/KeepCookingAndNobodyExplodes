extends Node3D

@onready var audio_player: AudioStreamPlayer3D = %AudioStreamPlayer3DRadio
@onready var audio_player_noise: AudioStreamPlayer3D = %AudioStreamPlayerStaticNoise
@onready var radio_light : MeshInstance3D = %RadioLight
@onready var radio_light_timer : Timer = %RadioLightTimer

@export var alert_sound: AudioStream 

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
	
	radio_light.visible = true
	radio_light_timer.stop()
	audio_player_noise.play()
	
	dialogue_system.start_dialogue(self, dialogue) 
	return true

func play_alert():
	audio_player.stream = alert_sound
	audio_player.play()
	
func _on_dialogue_alert(dialogue : DialogueResource):
	dialogue_queue.append(dialogue)
	play_alert()
	radio_light_timer.start()


func _on_static_body_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		print("input event mouse button")
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:			play_dialogue()

func _on_dialogue_finished():
	dialogue_queue.remove_at(0)
	radio_light.visible = false
	await get_tree().create_timer(1.5).timeout
	audio_player_noise.stop()

func toggle_radio_light_vis():
	radio_light.visible = not radio_light.visible

func _on_radio_light_timer_timeout() -> void:
	toggle_radio_light_vis()
