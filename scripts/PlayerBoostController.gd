extends ColorRect

@onready var game_manager = %GameManager
@onready var player = %Player
@onready var color_rect = $ColorRect

@export_range(0.0, 2.0) var boost_rate = 1.2
@export var consumption_rate = 80.0
@export var refuel_rate = 25.0
@export_range(0.1, 1.0) var ran_out_penalty_rate = 0.8
@export var blink_frequency = 1

var _initial_color: Color
var _boost_fuel = 100.0
var _ran_out = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_initial_color = color_rect.color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_manager.game_state != game_manager.GameStates.Running:
		return

	if _boost_fuel <= 0.0:
		_ran_out = true
	
	if _ran_out:
		player.boost_speed(ran_out_penalty_rate)
		
		if _boost_fuel >= 100.0:
			_ran_out = false
			_stop_blinking()
		else:
			_blink(delta)
			_refuel(delta)

		return
	
	if Input.is_action_pressed("ui_boost") and _boost_fuel > 0:
		player.boost_speed(boost_rate)
		_boost_fuel -= clamp(consumption_rate * delta, 0, 100.0)
		color_rect.size.x = remap(_boost_fuel, 0, 100, 0, size.x - color_rect.position.x * 2)
	elif not Input.is_action_pressed("ui_boost") and _boost_fuel < 100:
		player.boost_speed(1.0)
		_refuel(delta)

func _refuel(delta: float):
	_boost_fuel += clamp(refuel_rate * delta, 0, 100.0)
	color_rect.size.x = remap(_boost_fuel, 0, 100, 0, size.x - color_rect.position.x * 2)

#region Blinking

var _blink_prog = 0.0
var _blink_dir = 1

func _blink(delta):
	if _blink_prog == 0 or _blink_prog == 1:
		_blink_dir = -_blink_dir
		
	_blink_prog = clamp(_blink_prog + _blink_dir * blink_frequency * delta, 0, 1)
	color_rect.color = lerp(Color.DARK_RED, Color.DIM_GRAY, _blink_prog)
	
func _stop_blinking():
	color_rect.color = _initial_color
	_blink_prog = 0.0
	_blink_dir = 1

#endregion
