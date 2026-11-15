class_name Rulebook
extends Node

@export var rules: Array[Rule]
@export var rules_added_later: Array[Rule]
var next_rule_index = 0
@onready var entries: VBoxContainer = $CanvasLayer/BookPanel/ScrollContainer/Entries

func _ready() -> void:
	#var mush1: Mushroom = Mushroom.new()
	#mush1.set_merkmale(Game.cap_merkmale[0], Game.stem_merkmale[0], MaskMerkmal.new())
	#var mushes: Array[Mushroom] = [mush1]
	#check_poison_outcome(mushes)
	show_rules()
	EventManager.new_day.connect(add_new_rule)

func check_poison_outcome(mushrooms: Array[Mushroom]) -> int:
	var sum: int = 0
	for rule in rules:
		sum += rule.check_poison(mushrooms)
	print("Die Suppe hat ", sum, " Gift Punkte")
	return sum
	
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

func add_new_rule():
	rules.append(rules_added_later[next_rule_index])
	next_rule_index += 1
	if next_rule_index == rules_added_later.size():
		next_rule_index = 0
