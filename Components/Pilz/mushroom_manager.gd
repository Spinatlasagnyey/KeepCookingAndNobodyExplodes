class_name MushroomManager
extends Control

var mushroom: Mushroom = Mushroom.new()
@export var cap: TextureRect
@export var stem: TextureRect
@export var overlay: TextureRect
@export var prepared_mushroom: TextureRect

func _ready() -> void:
	roll_mushroom()

func roll_mushroom():
	mushroom = Mushroom.new()
	mushroom.set_merkmale(Game.cap_merkmale.pick_random(), Game.stem_merkmale.pick_random(), Game.mask_merkmale.pick_random())
	cap.texture = mushroom.cap.texture
	cap.modulate = Game.colors.pick_random()
	stem.texture = mushroom.stem.texture
	overlay.texture = mushroom.mask.texture
	var shader := overlay.material as ShaderMaterial
	shader.set_shader_parameter("mask_sampler", mushroom.cap.overlay_texture)

func prepare_mushroom(method: Game.PreparationMethod):
	mushroom.preparation_method = method
	if method == Game.PreparationMethod.CUT:
		prepared_mushroom.texture_filter
	if method == Game.PreparationMethod.SQUASHED:
		prepared_mushroom.texture_filter
##TO DOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo
