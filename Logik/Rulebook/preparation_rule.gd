class_name PreparationRule
extends Rule

@export var merkmal: Merkmal
@export var preparation_method: Game.PreparationMethod

@export var inversed: bool

@export var poison_effect = 1

func get_description() -> String:
	if merkmal == null:
		return "This rule needs a feature."

	var method_name := Game.get_preparation_name(preparation_method)
	var instruction := "Must be %s" % method_name
	if inversed:
		instruction = "Must not be %s" % method_name

	return "[center][b][font_size=36]%s[/font_size][/b]\n%s[/center]" % [
		instruction,
		merkmal_als_bild(merkmal)
	]

func get_merkmale() -> Array[Merkmal]:
	return [merkmal]

func check_poison(mushrooms: Array[Mushroom]) -> int:
	print(mushrooms.size())
	for pilz in mushrooms:
		for pilz_merkmal in pilz.merkmale:
			print(pilz_merkmal.part_name)
			if merkmal.part_name == pilz_merkmal.part_name:
				#print(merkmal.part_name, " ist ", pilz_merkmal.part_name)
				if inversed:
					if pilz.preparation_method == preparation_method:
						return poison_effect
				else:
					if pilz.preparation_method != preparation_method:
						print(Game.get_preparation_name(pilz.preparation_method), " ist nicht ", Game.get_preparation_name(preparation_method))
						print("+1 preparation")
						return poison_effect
	return 0
