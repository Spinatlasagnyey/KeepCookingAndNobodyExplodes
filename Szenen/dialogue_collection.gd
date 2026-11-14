class_name DialogueCollection
extends CanvasLayer

@export var dialogues: Dictionary[String, DialogueResource] = {}
@onready var dialogue_system: DialogueManager = $DialogueSystem

func play_dialogue(dialogue_id: String, caller: Node) -> void:
	var dialogue: DialogueResource = dialogues.get(dialogue_id)
	if dialogue == null:
		push_warning("Dialog fehlt: " + dialogue_id)
		return

	dialogue_system.start_dialogue(caller, dialogue)
