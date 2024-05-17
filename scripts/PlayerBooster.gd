extends Node

@export_category("Boost and Penalties")
@export var boost_rate: float
@export var running_out_penalty: float

@export_category("Fuel management")
@export var consumption_rate: float
@export var refueling_rate: float

var booster_controller: BoosterController

signal refueled(fuel: float)
signal fuel_consumed(fuel_level: float)
signal ran_out()


# Called when the node enters the scene tree for the first time.
func _ready():
	booster_controller = BoosterController.new(boost_rate, running_out_penalty, consumption_rate, refueling_rate)
	booster_controller.fuel_consumed.connect(_on_fuel_consumed)
	booster_controller.ran_out.connect(_on_ran_out)
	booster_controller.refueled.connect(_on_refueled)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Input.is_action_pressed("ui_boost") and booster_controller.can_boost:
		booster_controller.boost(delta)
	else:
		booster_controller.stop_boosting(delta)
		
	get_parent().boost_speed(booster_controller.rate)


#region Signals delegates

func _on_fuel_consumed(fuel_rate: float):
	fuel_consumed.emit(fuel_rate)


func _on_ran_out():
	ran_out.emit()


func _on_refueled(fuel_rate: float):
	refueled.emit(fuel_rate)

#endregion
