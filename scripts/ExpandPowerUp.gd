extends PowerUp

class_name ExpandPowerUp

@onready var game_manager = %GameManager
@export var multiplier = 1.2

func apply_effect(target: Paddle) -> void:
	var sprite = target.get_node("Sprite2D") as Node2D
	var collision_shape = target.get_node("CollisionShape2D") as CollisionShape2D

	sprite.scale *= multiplier
	collision_shape.shape.a.y = -sprite.scale.y / 2 - 8
	collision_shape.shape.b.y = sprite.scale.y / 2 + 8
