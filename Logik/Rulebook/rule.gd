class_name Rule
extends Resource

func get_description() -> String:
	return "No description."

func check_poison(mushrooms: Array[Mushroom]) -> int:
	return 0

func merkmal_als_bild(merkmal: Merkmal) -> String:
	return merkmal.merkmal_als_bild()
