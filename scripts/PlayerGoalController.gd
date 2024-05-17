extends Area2D

@onready var game_manager = %GameManager
@onready var ball = %Ball

func _on_body_entered(_body: Node2D):
	game_manager.player_score += 1
	ball.reset()
