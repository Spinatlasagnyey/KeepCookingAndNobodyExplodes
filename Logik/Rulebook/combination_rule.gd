class_name CombinationRule
extends Rule

@export var merkmal1: Merkmal
@export var merkmal2: Merkmal

@export var poison_effect: int = 1

func _init() -> void:
	call_deferred("set_description")

func set_description():
	description = "Wenn " + merkmal1.part_name + " dann nicht " + merkmal2.part_name

func check_poison(mushrooms: Array[Mushroom]) -> int:
	for pilz in mushrooms:
		for pilz_merkmal in pilz.merkmale:
			if merkmal1 == pilz_merkmal:
				for pilz2 in mushrooms:
					for pilz_merkmal2 in pilz2.merkmale:
						if merkmal2 == pilz_merkmal2:
							return poison_effect
	return 0
