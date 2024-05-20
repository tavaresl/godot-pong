extends Sprite2D

class_name PowerUpDurationIndicator

@export var radius = 0.0

var _angle = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# var power_up = get_parent().get_child(0)
	# var effect_timer = power_up.get_node("EffectTimer") as Timer
	# var time_left = effect_timer.time_left
	# var wait_time = effect_timer.wait_time

	# _angle = remap(effect_timer.time_left, 0.0, effect_timer.wait_time, 0.0, 360.0)
	pass

func _draw():
	draw_arc(position, 16, 0, _angle, 360, Color.WHITE_SMOKE, 4)
