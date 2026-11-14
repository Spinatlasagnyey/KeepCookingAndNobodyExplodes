extends Control

var mushroom: Mushroom = Mushroom.new()
@export var cap: TextureRect
@export var stem: TextureRect
@export var overlay: TextureRect

func _ready() -> void:
	mushroom.set_merkmale(Game.cap_merkmale.pick_random(), Game.stem_merkmale.pick_random(), Game.mask_merkmale.pick_random())
	cap.texture = mushroom.cap.texture
	stem.texture = mushroom.stem.texture
	overlay.texture = mushroom.mask.texture
	overlay.material.set("shader_paramater/mask_sampler",Vector3(1,1,1));
