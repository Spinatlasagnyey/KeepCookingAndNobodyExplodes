class_name PreparationRule
extends Rule

@export var merkmal: Merkmal
@export var preparation_method: Game.PreparationMethod

@export var inversed: bool

@export var poison_effect = 1

func get_description() -> String:
	if merkmal == null:
		return "This rules needs a feature."

	var bild := merkmal_als_bild(merkmal)
	var method_name := Game.get_preparation_name(preparation_method)

	if inversed:
		return "%s absolutely %s." % [bild, method_name]

	return "%s not %s." % [bild, method_name]

func get_merkmale() -> Array[Merkmal]:
	return [merkmal]

func check_poison(mushrooms: Array[Mushroom]) -> int:
	for pilz in mushrooms:
		for pilz_merkmal in pilz.merkmale:
			if merkmal == pilz_merkmal:
				if inversed:
					if pilz.preparation_method != preparation_method:
						return poison_effect
				else:
					if pilz.preparation_method == preparation_method:
						return poison_effect
	return 0
