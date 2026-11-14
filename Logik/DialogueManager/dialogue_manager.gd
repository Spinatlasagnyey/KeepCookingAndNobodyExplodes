class_name DialogueManager
extends Control

@onready var dialogue_box_animator: AnimationPlayer = $AnimationPlayer
@onready var dialogue_box_text: RichTextLabel = $DialogueSystem/DialogueBox/RichTextLabel
@onready var answers: DialogueAnswerManager = $Answers

@export var typing_delay: float = 0.02

var current_dialogue: DialogueResource
var current_caller: Node
var current_node: DialogueNode
var next_node_id: int = 0
var in_dialogue: bool = false
var is_typing: bool = false

func _ready() -> void:
	pass

func start_dialogue(caller: Node, dialogue: DialogueResource):
	if not in_dialogue:
		in_dialogue = true
		current_dialogue = dialogue
		current_caller = caller
		next_node_id = current_dialogue.start_id
		dialogue_box_animator.play("dialogue_box_open")
		
		continue_dialogue(true)
	else:
		print("already in dialogue")

func _unhandled_input(event: InputEvent) -> void:
	if not in_dialogue:
		return
	if event.is_action_pressed("interact") or Input.is_action_just_pressed("ui_back"):
		continue_dialogue()

func continue_dialogue(starting: bool = false):
	if not starting:
		if is_typing:
			is_typing = false
			dialogue_box_text.clear()
			dialogue_box_text.append_text(current_node.text)
			return
		if current_node.is_end:
			finish_dialogue()
			return
	current_node = current_dialogue.get_node(next_node_id)
	await type_sentence(current_node.text)
	if not current_node.answers.is_empty():
		answers.spawn_answers(current_node.answers)
	else:
		next_node_id = current_node.next_id

func type_sentence(sentence: String) -> void:
	is_typing = true
	dialogue_box_text.clear()
	var i := 0
	while i < sentence.length():
		if not is_typing:
			break
		if sentence[i] == "[":
			var end := sentence.find("]", i)
			if end != -1:
				var tag := sentence.substr(i, end - i + 1)
				dialogue_box_text.append_text(tag)
				i = end + 1
				continue
		dialogue_box_text.append_text(sentence[i])
		i += 1
		await get_tree().create_timer(typing_delay).timeout
	if is_typing: is_typing = false

func set_next_node_id(id: int):
	next_node_id = id

func finish_dialogue():
	in_dialogue = false
	if current_node.end_callable:
		if current_caller.has_method(current_node.end_callable):
			current_caller.call(current_node.end_callable)
		else:
			print(current_caller.name + ' does not have a function called: ' + current_node.end_callable)
	dialogue_box_animator.play_backwards("dialogue_box_open")
