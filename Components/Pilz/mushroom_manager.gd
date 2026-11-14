extends Control

var mushroom: Mushroom = Mushroom.new()
@export var cap: TextureRect
@export var stem: TextureRect
@export var overlay: TextureRect

func _ready() -> void:
	roll_mushroom()

func roll_mushroom():
	mushroom.set_merkmale(Game.cap_merkmale.pick_random(), Game.stem_merkmale.pick_random(), Game.mask_merkmale.pick_random())
	cap.texture = mushroom.cap.texture
	stem.texture = mushroom.stem.texture
	overlay.texture = mushroom.mask.texture
	var shader := overlay.material as ShaderMaterial
	shader.set_shader_parameter("mask_sampler", mushroom.cap.overlay_texture)
