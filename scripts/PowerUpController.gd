extends Node

@onready var available_timer: Timer = $"../AvailableTimer"
@onready var effect_timer: Timer = $"../EffectTimer"

var parent: Node2D

func _ready():
	parent = get_parent()
	pass

func _on_area_2d_body_entered(_body: Node2D):
	available_timer.stop()
	parent.picked.emit(parent)
	effect_timer.start()

func _on_available_timer_timeout():
	parent.availability_timeout.emit(parent)
	parent.queue_free()

func _on_effect_timer_timeout():
	parent.effect_timeout.emit(parent)
