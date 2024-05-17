extends Node

@onready var player = %Player
@onready var enemy = %Enemy
@onready var game_over = %GameOver
@onready var message_label = $"../GameOver/MessageLabel"

@export var max_score = 10

var booster_controller: BoosterController
var winner: Node2D = null

enum GameStates { Running, Paused, Over }

var scores = {}
var game_state: GameStates = GameStates.Running

var player_score: int:
	get:
		return scores[player.name]
		
var enemy_score: int:
	get:
		return scores[enemy.name]

func add_point_to(target: CharacterBody2D):
	scores[target.name] += 1
	_check_victory()

func _check_victory():
	if scores[player.name] == max_score:
		winner = player
	elif scores[enemy.name] == max_score:
		winner = enemy
		
	if winner == null:
		return

	game_state = GameStates.Over
	game_over.show()
	message_label.text = "You win!" if winner == player else "You lost."

func reset_scores():
	scores = {
		player.name: 0,
		enemy.name: 0,
	}

func _on_ready():
	reset_scores()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_restart_button_pressed():
	reset_scores()
	winner = null
	get_tree().reload_current_scene()
