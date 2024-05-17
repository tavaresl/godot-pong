class_name BoosterController

signal refueled(fuel: float)
signal fuel_consumed(fuel_level: float)
signal ran_out()

var _boost_rate: float
var _running_out_penalty: float
var _consumption_rate: float
var _refueling_rate: float

var _is_boosting = false
var _ran_out_of_fuel = false

var fuel = 100.0
var rate: float:
	get:
		if _ran_out_of_fuel:
			return _running_out_penalty
		elif _is_boosting:
			return _boost_rate
		else:
			return 1.0

var can_boost: bool:
	get:
		return fuel > 0.0 and not _ran_out_of_fuel

func _init(
	boost_rate: float,
	running_out_penalty: float,
	consumption_rate: float,
	refueling_rate: float,
):
	_boost_rate = boost_rate
	_running_out_penalty = running_out_penalty
	_consumption_rate = consumption_rate
	_refueling_rate = refueling_rate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if _ran_out_of_fuel:
		ran_out.emit()
		_refuel(delta)
		return

	if _is_boosting:
		_consume(delta)
	else:
		_refuel(delta)

func boost(delta: float):
	if can_boost:
		_is_boosting = true
		_consume(delta)
	else:
		stop_boosting(delta)

func stop_boosting(delta: float):
	_is_boosting = false
	_refuel(delta)

func _consume(delta: float):
	if not can_boost:
		return

	_is_boosting = true
	fuel -= clamp(_consumption_rate * delta, 0, 100.0)
	fuel_consumed.emit(fuel)

	if fuel <= 0.0:
		_ran_out_of_fuel = true
		ran_out.emit()

func _refuel(delta: float):
	if fuel >= 100.0:
		_ran_out_of_fuel = false
		return

	if not _is_boosting and fuel < 100.0:
		fuel += clamp(_refueling_rate * delta, 0, 100.0)
		refueled.emit(fuel)
