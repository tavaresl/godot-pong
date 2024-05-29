extends Node

class_name GameStateObserver

@export var states_to_process: Array[GameStateController.GameStates] = []
var _initial_process_mode: ProcessMode

# Called when the node enters the scene tree for the first time.
func _ready():
	_initial_process_mode = get_parent().process_mode
	GameStateManager.state_changed.connect(_on_game_state_manager_state_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_game_state_manager_state_changed(_prev, new_state):
	if not new_state in states_to_process:
		call_deferred("_disable_parent")
	else:
		call_deferred("_enable_parent")

func _disable_parent():
	get_parent().process_mode = Node.PROCESS_MODE_DISABLED

func _enable_parent():
	get_parent().process_mode = _initial_process_mode
