class_name MushroomManager
extends Control

var mushroom: Mushroom = Mushroom.new()
@export var cap: TextureRect
@export var stem: TextureRect
@export var overlay: TextureRect
@export var prepared_mushroom: TextureRect

@onready var squashed = preload("res://Assets/Pilze/Mashed.png")
@onready var cut = preload("res://Assets/Pilze/cutted.png")

func _ready() -> void:
	roll_mushroom()

func roll_mushroom():
	prepared_mushroom.texture = null
	$Mushroom.visible = true
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
	$Mushroom.visible = false
	if method == Game.PreparationMethod.CUT:
		prepared_mushroom.texture = cut
	if method == Game.PreparationMethod.SQUASHED:
		prepared_mushroom.texture = squashed
