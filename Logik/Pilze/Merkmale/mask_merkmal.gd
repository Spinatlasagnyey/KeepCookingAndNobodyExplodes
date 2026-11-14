class_name MaskMerkmal
extends Merkmal

@export var img_texture: Texture2D

func merkmal_als_bild(merkmal: Merkmal) -> String:
	if merkmal.texture == null:
		return merkmal.part_name

	return "[img height=48]%s[/img]" % merkmal.texture.resource_path
