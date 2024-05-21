extends PowerUp

class_name ExpandPowerUp

@onready var game_manager = %GameManager
@export var multiplier = 1.2

var original_scale: Vector2

func apply_effect(target: Paddle) -> void:
	if original_scale == Vector2.ZERO:
		original_scale = target.scale

	target.scale = original_scale * multiplier

func remove_effect(target: Paddle):
	multiplier = 1.0
	target.scale = original_scale
