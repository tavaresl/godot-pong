extends Node

@onready var ball = %Ball
@export var boost_rate = 1.2
@export var consumption_rate = 80.0
@export var refuel_rate = 25.0
@export_range(0.1, 1.0) var ran_out_penalty_rate = 0.8

var _ran_out = false
var _fuel = 100.0
var _parent: EnemyController

# Called when the node enters the scene tree for the first time.
func _ready():
	_parent = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ball.dir.x < 0:
		_parent.boost_speed(1.0)
		return

	if _fuel <= 0:
		_ran_out = true
		
	if _ran_out:
		_parent.boost_speed(ran_out_penalty_rate)
		_refuel(delta)
		return

	var distance = abs(ball.position.y - _parent.position.y)
	
	if distance >= _parent.min_boost_distance:
		_parent.boost_speed(boost_rate)
		_fuel -= clamp(consumption_rate * delta, 0, 100.0)
	else:
		_parent.boost_speed(1.0)
		_refuel(delta)


func _refuel(delta):
	if _fuel < 100:
		_fuel += clamp(refuel_rate * delta, 0, 100.0)
	else:
		_ran_out = false
