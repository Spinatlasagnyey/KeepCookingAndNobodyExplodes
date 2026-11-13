extends Control
class_name UI

@onready var hunger_bar: ProgressBar = %HungerProgressBar
@onready var poison_bar: ProgressBar = %PoisonProgressBar
@onready var game_over_label : Label = %GameOverLabel
func update_hunger_value(new_value : float):
	hunger_bar.value = new_value
	
func update_poison_value(new_value : float):
	poison_bar.value = new_value
	
func toggle_game_over_vis():
	game_over_label.visible = not game_over_label.visible
