extends PowerUp

@onready var game_manager = %GameManager

var original_scale: Vector2
var multiplier = 1.2
var paddle: Paddle = null

func apply_effect(target: Paddle) -> void:
	# var sprite = target.get_node("Sprite2D") as Node2D

	if original_scale == Vector2.ZERO:
		original_scale = target.scale

	target.scale = original_scale * multiplier

func remove_effect(target: Paddle):
	# var sprite = target.get_node("Sprite2D") as Node2D
	multiplier = 1.0
	target.scale = original_scale
