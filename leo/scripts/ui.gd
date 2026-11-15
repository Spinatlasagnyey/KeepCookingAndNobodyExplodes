extends Control
class_name UI

@onready var time_bar: ProgressBar = %TimerProgressBar
@onready var hunger_bar: ProgressBar = %HungerProgressBar
@onready var poison_bar: ProgressBar = %PoisonProgressBar
@onready var game_over_label : Label = %GameOverLabel
@onready var game_over_panel : Panel = %GameOverPanel
@onready var day_label : Label = %Day

var day_time_sec : float

func _ready() -> void:
	EventManager.game_over_signal.connect(_on_game_over)
	EventManager.new_day.connect(_on_new_day)
	
	EventManager.hunger_value_changed.connect(_on_hunger_value_changed)
	EventManager.poison_value_changed.connect(_on_poison_value_changed)
	EventManager.time_passed_changed.connect(_on_time_passed_changed)
	
func toggle_game_over_vis():
	game_over_panel.visible = not game_over_panel.visible

func _on_hunger_value_changed(value : float):
	hunger_bar.value = value
	
func _on_poison_value_changed(value : float):
	poison_bar.value = value
	
func _on_game_over(game_over_message : String):
	print("ui _on_game_over")
	game_over_label.text = game_over_message
	toggle_game_over_vis()
	
func _on_time_passed_changed(value : float):
	time_bar.value = day_time_sec - value
	
func _on_new_day(dayInt: int, new_day_time_sec : float):
	print("ui _on_new_day")
	day_label.text = "DAY " + str(dayInt)
	
	day_time_sec = new_day_time_sec
	time_bar.max_value = day_time_sec
	time_bar.value = time_bar.max_value
	
func _on_restart_button_button_up() -> void:
	toggle_game_over_vis()
	
	get_tree().reload_current_scene()
	EventManager.reset()

	
