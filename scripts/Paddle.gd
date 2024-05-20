extends CharacterBody2D

class_name Paddle

@export var base_speed = 400.0
@onready var speed = base_speed

var power_ups: Array[PowerUp] = []

func add_power_up(power_up: PowerUp) -> void:
	power_ups.append(power_up)

func remove_power_up(power_up: PowerUp) -> void:
	power_ups.remove_at(power_ups.find(power_up))

func boost_speed(rate: float) -> void:
	speed = base_speed * rate

func _process(_delta):
	for power_up in power_ups:
		power_up.apply(self)
