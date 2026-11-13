extends Node
@onready var hunger_timer : Timer = %HungerTimer
@onready var ui : UI = %Ui

@export var hunger_per_timeout : float

const STARTING_HUNGER = 100
const STARTING_POISON = 0
const MAX_POISON = 100 

var current_hunger
var current_poison

var is_game_over = false

func _ready() -> void:
	current_hunger = STARTING_HUNGER
	current_poison = STARTING_POISON
	
	ui.update_hunger_value(current_hunger)
	ui.update_poison_value(current_poison)
	
	hunger_timer.start()
	
func _physics_process(delta: float) -> void:
	# hier vielleicht basierend auf aktuellem PoisonLevel 
	# psychedelische Effekte einbauen
	if Input.is_action_just_pressed("add_poison_debug"):
		print("poisoned")
		addPoison(5.0)


func _on_hunger_timer_timeout() -> void:
	print("hunger_timeout")
	current_hunger -= hunger_per_timeout
	ui.update_hunger_value(current_hunger)
	if ui.hunger_bar.value <= 0:
		game_over("YOU STARVED")
		
func game_over(text : String):
	if not is_game_over:
		ui.game_over_label.text = text
		ui.toggle_game_over_vis()
		hunger_timer.stop()
	is_game_over = true

func addPoison(amount : float):
	current_poison += amount
	ui.update_poison_value(current_poison)
	if current_poison >= MAX_POISON:
		game_over("YOU EXPLODED (TOO MUCH POISON)")
	
	
