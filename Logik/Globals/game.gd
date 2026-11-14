extends Node

var merkmal_rescourcen = ["res://Logik/Pilze/Merkmale/Rescourcen/Cap1.tres", "res://Logik/Pilze/Merkmale/Rescourcen/Stem1.tres"]

var stem_merkmale: Array[StemMerkmal]
var cap_merkmale: Array[CapMerkmal]
var mask_merkmal: Array[MaskMerkmal]

func _ready() -> void:
	for merkmal in merkmal_rescourcen:
		var m: Merkmal = load(merkmal)
		if m and m is Merkmal:
			if m is StemMerkmal:
				stem_merkmale.append(m)
			elif m is CapMerkmal:
				cap_merkmale.append(m)
			elif m is MaskMerkmal:
				mask_merkmal.append(m)

enum PreparationMethod {
	CUT,
	SQUASHED
}

func get_preparation_name(preparation_method: PreparationMethod) -> String:
	if preparation_method == PreparationMethod.CUT:
		return "cut"
	if preparation_method == PreparationMethod.SQUASHED:
		return "squashed"
	return "whomp whomp"
