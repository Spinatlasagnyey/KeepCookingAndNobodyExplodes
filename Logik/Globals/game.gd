extends Node

var merkmal_rescourcen = ["res://Logik/Pilze/Merkmale/Rescourcen/Cap1.tres",  
"res://Logik/Pilze/Merkmale/Rescourcen/Cap2.tres",
"res://Logik/Pilze/Merkmale/Rescourcen/Cap3.tres",
"res://Logik/Pilze/Merkmale/Rescourcen/Cap4.tres",
"res://Logik/Pilze/Merkmale/Rescourcen/Cap5.tres",
"res://Logik/Pilze/Merkmale/Rescourcen/Cap6.tres",
"res://Logik/Pilze/Merkmale/Rescourcen/Stem1.tres", 
"res://Logik/Pilze/Merkmale/Rescourcen/Stem2.tres",
"res://Logik/Pilze/Merkmale/Rescourcen/Stem3.tres",
"res://Logik/Pilze/Merkmale/Rescourcen/Stem4.tres",
"res://Logik/Pilze/Merkmale/Rescourcen/Stem5.tres",
"res://Logik/Pilze/Merkmale/Rescourcen/Stem6.tres",
"res://Logik/Pilze/Merkmale/Rescourcen/Mask1.tres"]

var stem_merkmale: Array[StemMerkmal]
var cap_merkmale: Array[CapMerkmal]
var mask_merkmale: Array[MaskMerkmal]

func _init() -> void:
	for merkmal in merkmal_rescourcen:
		var m: Merkmal = load(merkmal)
		if m and m is Merkmal:
			if m is StemMerkmal:
				stem_merkmale.append(m)
			elif m is CapMerkmal:
				cap_merkmale.append(m)
			elif m is MaskMerkmal:
				mask_merkmale.append(m)

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
