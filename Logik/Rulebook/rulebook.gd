class_name Rulebook
extends Node

@export var rules: Array[Rule]
@onready var entries: VBoxContainer = $CanvasLayer/BookPanel/ScrollContainer/Entries

func _ready() -> void:
	var mush1: Mushroom = Mushroom.new()
	mush1.set_merkmale(Game.cap_merkmale[0], Game.stem_merkmale[0], MaskMerkmal.new())
	var mushes: Array[Mushroom] = [mush1]
	check_poison_outcome(mushes)
	show_rules()

func check_poison_outcome(mushrooms: Array[Mushroom]):
	var sum: int = 0
	for rule in rules:
		sum += rule.check_poison(mushrooms)
	print("Die Suppe hat ", sum, " Gifft Punkte")
	
func show_rules() -> void:
	for rule in rules:
		if rule == null:
			continue

		var description_label := RichTextLabel.new()
		description_label.bbcode_enabled = true
		description_label.fit_content = true
		description_label.scroll_active = false
		description_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		description_label.text = rule.get_description()
		entries.add_child(description_label)
