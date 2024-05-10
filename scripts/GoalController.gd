extends Area2D

@onready var ball = %Ball
@onready var game_manager = %GameManager
@export var target: CharacterBody2D

func _on_body_entered(body: Node2D):
	game_manager.add_point_to(target)
	ball.reset()
