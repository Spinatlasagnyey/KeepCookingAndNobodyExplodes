extends Node

signal time_passed_changed(value: float)
signal hunger_value_changed(value : float)
signal poison_value_changed(value : float)
signal game_over_signal(game_over_message : String)
signal new_day(dayInt : int, seconds_per_day : float)
signal dialogue_alert(dialogue : DialogueResource)

const SECONDS_PER_DAY = 180
const RESCUE_DAY = 7

const STARTING_FULLNESS = 0
const MAX_FULLNESS = 5
const HUNGER_PER_DAY = 3

const STARTING_POISON = 0
const MAX_POISON = 20 
const MINUS_POISON_PER_DAY = 20

@onready var day_timer : Timer = %DayTimer

@export var dialogue_schedule: Array[DialogueScheduled] = []
var working_dialogue_schedule : Array[DialogueScheduled]

var time_passed : float = 0.0
var current_day : int = 1
var current_fullness
var current_poison

var is_game_over = false

func _ready() -> void:
	working_dialogue_schedule = dialogue_schedule.duplicate()
	
	current_fullness = STARTING_FULLNESS
	current_poison = STARTING_POISON
	await get_tree().process_frame
	hunger_value_changed.emit(current_fullness)
	poison_value_changed.emit(current_poison)
	
	# erster Tag
	new_day.emit(current_day, SECONDS_PER_DAY)
	time_passed_changed.emit(time_passed)
	
	start_day_timer()
	
	
func _physics_process(_delta: float) -> void:
	# hier vielleicht basierend auf aktuellem PoisonLevel 
	# psychedelische Effekte einbauen
	if Input.is_action_just_pressed("add_poison_debug"):
		add_poison(5.0)
		print("poisoned")
		
	#if Input.is_action_just_pressed("ui_accept"):
		#start_day_timer()
		#print("timer started")
	
	if Input.is_action_just_pressed("add_fullness_debug"):
		add_fullness(1.0)
		print("add fullness")
		
	check_game_over()
	
	check_dialogue_due()
		
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

func check_dialogue_due():
	if working_dialogue_schedule.is_empty():
		return
	var day_time_progress = time_passed / SECONDS_PER_DAY
	for dialogue_scheduled in working_dialogue_schedule:
		if dialogue_scheduled.day <= current_day and dialogue_scheduled.time_of_day_percent <= day_time_progress:
			# Zeitpunkt eines Events erreicht / überschritten
			print(str(dialogue_scheduled) + " fällig")
			dialogue_alert.emit(dialogue_scheduled.dialogue_resource)
			working_dialogue_schedule.erase(dialogue_scheduled)
			
func get_day_progress() -> float:
	var elapsed := time_passed

	if not day_timer.is_stopped():
		elapsed += day_timer.wait_time - day_timer.time_left

	return clampf(elapsed / float(SECONDS_PER_DAY), 0.0, 1.0)
