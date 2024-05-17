extends Node

@onready var ball = %Ball
@export var boost_rate = 1.2
@export var consumption_rate = 80.0
@export var refuel_rate = 25.0
@export_range(0.1, 1.0) var ran_out_penalty_rate = 0.8

var _parent: EnemyController
var booster_controller: BoosterController

# Called when the node enters the scene tree for the first time.
func _ready():
	_parent = get_parent()
	booster_controller = BoosterController.new(boost_rate, ran_out_penalty_rate, consumption_rate, refuel_rate)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ball.dir.x < 0:
		booster_controller.stop_boosting(delta)
		return

	var distance = abs(ball.position.y - _parent.position.y)

	if distance >= _parent.min_boost_distance:
		booster_controller.boost(delta)
	else:
		booster_controller.stop_boosting(delta)

	_parent.boost_speed(booster_controller.rate)
