class_name Mushroom
extends Resource

var stem: StemMerkmal
var cap: CapMerkmal
var mask: MaskMerkmal

var preparation_method: Game.PreparationMethod = Game.PreparationMethod.UNTOUCHED

var merkmale: Array[Merkmal]

func set_merkmale(cap_merkmal: CapMerkmal, stem_merkmal: StemMerkmal, mask_merkmal: MaskMerkmal):
	stem = stem_merkmal
	cap = cap_merkmal
	mask = mask_merkmal
	merkmale.clear()
	if cap:
		merkmale.append(cap)
	if stem:
		merkmale.append(stem)
	if mask:
		merkmale.append(mask)
