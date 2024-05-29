extends Node

class_name GameStateController

var current_state: GameStates:
	get:
		return current_state

	set(new_state):
		if new_state in allowed_next_states[current_state]:
			var prev_state = current_state
			current_state = new_state
			state_changed.emit(prev_state, current_state)
		else:
			push_warning("FORBIDDEN_STATE_TRANSITION: from " + str(current_state) + " to " + str(new_state))

enum GameStates {RUNNING, STARTING, CASTING_POWER_UP, UNCASTING_POWER_UP, SCORING, GAME_OVER}

static var allowed_next_states = {
	GameStates.RUNNING: [GameStates.CASTING_POWER_UP, GameStates.UNCASTING_POWER_UP, GameStates.SCORING, GameStates.GAME_OVER],
	GameStates.STARTING: [GameStates.RUNNING],
	GameStates.CASTING_POWER_UP: [GameStates.RUNNING],
	GameStates.UNCASTING_POWER_UP: [GameStates.RUNNING],
	GameStates.SCORING: [GameStates.STARTING, GameStates.GAME_OVER],
	GameStates.GAME_OVER: [GameStates.STARTING],
}

signal state_changed(previous: GameStates, current: GameStates)

func _enter_tree():
	pass

func _ready():
	print("Game State Manager started")
	pass

func _process(delta):
	pass
