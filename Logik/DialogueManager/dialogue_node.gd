class_name DialogueNode
extends Resource

@export_multiline var text: String

@export var answers: Array[DialogueAnswer] = []

@export var next_id: int = -1

@export var is_end: bool = false

@export var end_callable: String = ""
