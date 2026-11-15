extends Control

var soup: Array[Mushroom] = []

@export var max_soup_size: int = 6
@onready var rulebook: Rulebook = get_tree().get_first_node_in_group("rulebook")
@onready var canvas: CanvasLayer = get_tree().get_first_node_in_group("canvas_layer")
@onready var sfx_game: Node2D = $Audio;
const ALREADY_FULL_WARNING = preload("res://Components/Cooking/already_full_warning.tscn")

@export var mushroom_ui: MushroomManager

var mushroom_prepared := false

func _process(delta: float) -> void:
	pass

func add_to_soup(mushroom: Mushroom):
	if soup.size() == max_soup_size:
		if canvas:
			var inst = ALREADY_FULL_WARNING.instantiate()
			canvas.add_child(inst)
		visible = false
		return
	sfx_game.get_node("PutInPot").play();
	soup.append(mushroom)
	
	mushroom_ui.roll_mushroom()
	mushroom_prepared = false
	visible = false

func discard_mushroom():
	visible = false
	mushroom_ui.roll_mushroom()
	mushroom_prepared = false

func pick_up_mushroom():
	visible = true

func cook():
	if rulebook:
		print(soup.size())
		EventManager.add_fullness(soup.size())
		var poison = rulebook.check_poison_outcome(soup)
		EventManager.add_poison(poison)
		soup.clear()
		visible = false
	else:
		print("rulebook missing")


func _on_trash_mushroom_pressed() -> void:
	discard_mushroom()

func _on_put_down_mushroom_pressed() -> void:
	visible = false

func _on_use_mushroom_pressed() -> void:
	add_to_soup(mushroom_ui.mushroom)

func _on_squash_mushroom_pressed() -> void:
	if not mushroom_prepared:
		sfx_game.get_node("Squash").play()
		mushroom_prepared = true
		mushroom_ui.prepare_mushroom(Game.PreparationMethod.SQUASHED)

func _on_cut_mushroom_pressed() -> void:
	if not mushroom_prepared:
		sfx_game.get_node("Cut").play()
		mushroom_prepared = true
		mushroom_ui.prepare_mushroom(Game.PreparationMethod.CUT)

func _on_cook_pressed() -> void:
	cook()
