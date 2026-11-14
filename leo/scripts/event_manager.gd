extends Node
@onready var day_timer : Timer = %DayTimer

signal time_passed_changed(value: float)
signal hunger_value_changed(value : float)
signal poison_value_changed(value : float)
signal game_over_signal(game_over_message : String)
signal new_day(dayInt : int, seconds_per_day : float)

const SECONDS_PER_DAY = 3
const RESCUE_DAY = 7

const STARTING_FULLNESS = 0
const MAX_FULLNESS = 5
const HUNGER_PER_DAY = 3

const STARTING_POISON = 0
const MAX_POISON = 100 
const MINUS_POISON_PER_DAY = 20

var time_passed : float = 0.0
var current_day : int = 1
var current_fullness
var current_poison

var is_game_over = false

func _ready() -> void:
	current_fullness = STARTING_FULLNESS
	current_poison = STARTING_POISON
	await get_tree().process_frame
	hunger_value_changed.emit(current_fullness)
	poison_value_changed.emit(current_poison)
	
	# erster Tag
	new_day.emit(current_day, SECONDS_PER_DAY)
	time_passed_changed.emit(time_passed)
	
	
func _physics_process(delta: float) -> void:
	# hier vielleicht basierend auf aktuellem PoisonLevel 
	# psychedelische Effekte einbauen
	if Input.is_action_just_pressed("add_poison_debug"):
		add_poison(5.0)
		print("poisoned")
		
	if Input.is_action_just_pressed("ui_accept"):
		start_day_timer()
		print("timer started")
	
	if Input.is_action_just_pressed("add_fullness_debug"):
		add_fullness(1.0)
		print("add fullness")
		
	check_game_over()
		
func _on_day_timer_timeout() -> void:
	print("timer timeout")
	time_passed += day_timer.wait_time
	time_passed_changed.emit(time_passed)
		
func game_over(game_over_message : String):
	if not is_game_over:
		game_over_signal.emit(game_over_message)
		day_timer.stop()
	is_game_over = true

func add_poison(amount : float):
	current_poison += amount
	poison_value_changed.emit(current_poison)
	
func add_fullness(amount : float):
	current_fullness = min(MAX_FULLNESS, current_fullness + amount)
	hunger_value_changed.emit(current_fullness)
		
func start_day_timer():
	day_timer.start()
	
func check_game_over():
	if current_poison >= MAX_POISON:
		game_over("YOU EXPLODED (TOO MUCH POISON)")
	
	if time_passed >= SECONDS_PER_DAY:
		if current_fullness < HUNGER_PER_DAY:
			game_over("YOU STARVED")
		else: 
			if current_day == RESCUE_DAY:
				game_over("YOU WERE RESCUED")
			else:
				start_new_day()
		
func start_new_day():
	current_day += 1
	time_passed = 0
	time_passed_changed.emit(time_passed)
	new_day.emit(current_day,SECONDS_PER_DAY)
	
	current_fullness -= HUNGER_PER_DAY
	hunger_value_changed.emit(current_fullness)
	current_poison -= max(0, MINUS_POISON_PER_DAY)
	poison_value_changed.emit(current_poison)
