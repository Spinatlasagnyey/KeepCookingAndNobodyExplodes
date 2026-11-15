class_name MaskMerkmal
extends Merkmal

@export var img_texture: Texture2D

func merkmal_als_bild() -> String:
	if img_texture == null:
		return part_name

	return "[img height=48]%s[/img]" % img_texture.resource_path
