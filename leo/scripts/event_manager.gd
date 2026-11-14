extends Node
@onready var hunger_timer : Timer = %HungerTimer

signal hunger_value_changed(value : float)
signal poison_value_changed(value : float)
signal game_over_signal(game_over_message : String)

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
	await get_tree().process_frame
	
	hunger_value_changed.emit(current_hunger)
	poison_value_changed.emit(current_poison)

	
func _physics_process(delta: float) -> void:
	# hier vielleicht basierend auf aktuellem PoisonLevel 
	# psychedelische Effekte einbauen
	if Input.is_action_just_pressed("add_poison_debug"):
		print("poisoned")
		addPoison(5.0)
		
	if Input.is_action_just_pressed("ui_accept"):
		start_hunger_timer()


func _on_hunger_timer_timeout() -> void:
	print("hunger_timeout")
	current_hunger -= hunger_per_timeout
	hunger_value_changed.emit(current_hunger)
	if current_hunger <= 0:
		game_over("YOU STARVED")
		
func game_over(game_over_message : String):
	if not is_game_over:
		game_over_signal.emit(game_over_message)
		hunger_timer.stop()
	is_game_over = true

func addPoison(amount : float):
	current_poison += amount
	poison_value_changed.emit(current_poison)
	if current_poison >= MAX_POISON:
		game_over("YOU EXPLODED (TOO MUCH POISON)")
	
func start_hunger_timer():
	hunger_timer.start()
