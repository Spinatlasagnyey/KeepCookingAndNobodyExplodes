class_name Merkmal
extends Resource

@export var part_name: String
@export var texture: Texture2D

func merkmal_als_bild() -> String:
	if texture == null:
		return part_name

	return "[img height=256]%s[/img]" % texture.resource_path
