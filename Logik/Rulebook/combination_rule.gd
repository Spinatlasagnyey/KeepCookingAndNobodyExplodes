class_name CombinationRule
extends Rule

@export var merkmal1: Merkmal
@export var merkmal2: Merkmal

@export var poison_effect: int = 1

func get_description() -> String:
	if merkmal1 == null or merkmal2 == null:
		return "This rules needs a feature."

	return "Do not cook %s and %s together." % [
		merkmal_als_bild(merkmal1),
		merkmal_als_bild(merkmal2)
	]


func get_merkmale() -> Array[Merkmal]:
	return [merkmal1, merkmal2]

func check_poison(mushrooms: Array[Mushroom]) -> int:
	for pilz in mushrooms:
		for pilz_merkmal in pilz.merkmale:
			if merkmal1 == pilz_merkmal:
				for pilz2 in mushrooms:
					for pilz_merkmal2 in pilz2.merkmale:
						if merkmal2 == pilz_merkmal2:
							return poison_effect
	return 0
