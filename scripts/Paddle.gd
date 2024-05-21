extends CharacterBody2D

class_name Paddle

@export var base_speed = 400.0
@onready var speed = base_speed

func boost_speed(rate: float) -> void:
	speed = base_speed * rate
