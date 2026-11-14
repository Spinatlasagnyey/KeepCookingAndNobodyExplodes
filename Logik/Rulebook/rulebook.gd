class_name Rulebook
extends Node

@export var rules: Array[Rule]

func _ready() -> void:
	var mush1: Mushroom = Mushroom.new()
	mush1.set_merkmale(Game.cap_merkmale[0], Game.stem_merkmale[0], MaskMerkmal.new())
	var mushes: Array[Mushroom] = [mush1]
	check_poison_outcome(mushes)

func check_poison_outcome(mushrooms: Array[Mushroom]):
	var sum: int = 0
	for rule in rules:
		sum += rule.check_poison(mushrooms)
	print("The soup has ", sum, " poison points")
