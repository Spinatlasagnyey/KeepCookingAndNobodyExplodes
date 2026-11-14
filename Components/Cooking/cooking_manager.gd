extends Control

var soup: Array[Mushroom] = []
@onready var rulebook: Rulebook = get_tree().get_first_node_in_group("rulebook")

@export var mushroom_ui: MushroomManager

var mushroom_prepared := false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		visible = true

func add_to_soup(mushroom: Mushroom):
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

func _on_trash_mushroom_pressed() -> void:
	discard_mushroom()

func _on_put_down_mushroom_pressed() -> void:
	visible = false

func _on_use_mushroom_pressed() -> void:
	add_to_soup(mushroom_ui.mushroom)

func _on_squash_mushroom_pressed() -> void:
	mushroom_prepared = true
	mushroom_ui.prepare_mushroom(Game.PreparationMethod.SQUASHED)

func _on_cut_mushroom_pressed() -> void:
	mushroom_prepared = true
	mushroom_ui.prepare_mushroom(Game.PreparationMethod.CUT)


func _on_cook_pressed() -> void:
	if rulebook:
		var poison = rulebook.check_poison_outcome(soup)
		EventManager.add_poison(poison)
	else:
		print("rulebook missing")
