extends Sprite2D

class_name PowerUp

signal picked(power_up: PowerUp)
signal availability_timeout(power_up: PowerUp)
signal effect_timeout(power_up: PowerUp)

@export var power_up_name: String

func apply_effect(_target: Paddle) -> void:
	push_error("UNIMPLEMENTED ERROR: PowerUp.apply_effect(_target)")
