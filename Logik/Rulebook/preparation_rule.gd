class_name PreparationRule
extends Rule

@export var merkmal: Merkmal
@export var preparation_method: Game.PreparationMethod

@export var inversed: bool

@export var poison_effect = 1

func _init() -> void:
	call_deferred("set_description")

func set_description():
	if inversed:
		description = "Wenn " + merkmal.part_name + " dann " + Game.get_preparation_name(preparation_method)
	else:
		description = "Wenn " + merkmal.part_name + " dann nicht " + Game.get_preparation_name(preparation_method)

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
