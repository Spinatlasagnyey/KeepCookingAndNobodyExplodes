class_name AnswerButton
extends Button

var next_id: int
var is_negative: bool

@onready var answer_label: RichTextLabel = $RichTextLabel
signal answer_pressed(id: int)
signal selected(node: Node)

func _ready() -> void:
	self.pressed.connect(on_answer_pressed)
	self.focus_entered.connect(on_selected)

func set_answer_text(content: String):
	answer_label.append_text(content)

func on_answer_pressed():
	answer_pressed.emit(next_id)
	
func on_selected():
	selected.emit(self)
