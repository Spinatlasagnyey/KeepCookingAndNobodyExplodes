extends Control
class_name UI

@onready var hunger_bar: ProgressBar = %HungerProgressBar
@onready var poison_bar: ProgressBar = %PoisonProgressBar
@onready var game_over_label : Label = %GameOverLabel

func _ready() -> void:
	EventManager.game_over_signal.connect(_on_game_over)
	EventManager.hunger_value_changed.connect(_on_hunger_value_changed)
	EventManager.poison_value_changed.connect(_on_poison_value_changed)
	
func toggle_game_over_vis():
	game_over_label.visible = not game_over_label.visible

func _on_hunger_value_changed(value : float):
	hunger_bar.value = value
	
func _on_poison_value_changed(value : float):
	poison_bar.value = value
	
func _on_game_over(game_over_message : String):
	game_over_label.text = game_over_message
	toggle_game_over_vis()
	
