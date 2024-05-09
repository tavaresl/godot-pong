extends Area2D

@onready var game_manager = %GameManager

func _on_body_entered(body: Node2D):
	game_manager.player_score += 1
	body.position = Vector2.ZERO
	pass # Replace with function body.
