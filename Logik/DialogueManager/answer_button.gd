class_name AnswerButton
extends TextureButton

var next_id: int
var is_negative: bool

@onready var text: RichTextLabel = $RichTextLabel
signal answer_pressed(id: int)
signal selected(node: Node)

func _ready() -> void:
	self.pressed.connect(on_answer_pressed)
	self.focus_entered.connect(on_selected)

func set_text(content: String):
	text.append_text(content)

func on_answer_pressed():
	answer_pressed.emit(next_id)
	
func on_selected():
	selected.emit(self)
