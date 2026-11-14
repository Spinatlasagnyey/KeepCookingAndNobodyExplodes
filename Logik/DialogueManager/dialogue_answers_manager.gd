class_name DialogueAnswerManager
extends VBoxContainer

@onready var dialogue_system: DialogueManager = $".."
@export var answer_preload: PackedScene

var answers_available: bool = false
var selected_answer: AnswerButton

func _input(event: InputEvent) -> void:
	if answers_available:
		if Input.is_action_just_pressed("interact"):
			send_answer(selected_answer.next_id)
			remove_answers()
			get_viewport().set_input_as_handled()
		if Input.is_action_just_pressed("ui_back"):
			var negative_answer = get_negative_answer()
			get_viewport().set_input_as_handled()
			if negative_answer:
				send_answer(negative_answer.next_id)
				remove_answers()

func get_negative_answer():
	for child in get_children():
		if child.is_negative:
			return child
	return null

func spawn_answers(answers: Array[DialogueAnswer]): #tomorrow make answers selectable and working with outline i hope
	for answer in answers:
		var inst: AnswerButton = answer_preload.instantiate()
		add_child(inst)
		inst.set_answer_text(answer.text)
		inst.next_id = answer.next_id
		inst.is_negative = answer.is_negative
		inst.answer_pressed.connect(answer_pressed)
		inst.selected.connect(answer_selected)
		answers_available = true
	get_children()[0].grab_focus()

func remove_answers():
	for child in get_children():
		child.queue_free()
	answers_available = false

func answer_pressed(id: int):
	send_answer(id)
	remove_answers()

func send_answer(id: int):
	dialogue_system.set_next_node_id(id)
	dialogue_system.continue_dialogue()

func answer_selected(node: Node):
	selected_answer = node
