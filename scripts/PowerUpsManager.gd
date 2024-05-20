extends Node

@export var spawn_area_start: Vector2 = Vector2(640, 320)
@export var spawn_area_end: Vector2 = Vector2(1280, 720)

@export var power_ups: Array[PackedScene] = [
	preload ("res://scenes/expand_power_up.tscn"),
]

@onready var _power_up_control = preload ("res://scenes/power_up_control.tscn")
@onready var _player_picked_area: HBoxContainer = $PlayerPowerUps/PowerUpsContainer
@onready var _enemy_picked_area: HBoxContainer = $EnemyPowerUps/PowerUpsContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player_power_ups = _player_picked_area.get_children()
	var enemy_power_ups = _enemy_picked_area.get_children()

	for node in player_power_ups:
		if node != null:
			var power_up = node.get_node("PowerUp") as PowerUp
			power_up.apply_effect( %Player)

	for node in enemy_power_ups:
		if node != null:
			var power_up = node.get_node("PowerUp") as PowerUp
			power_up.apply_effect( %Enemy)

func spawn(power_up: PackedScene):
	var instance = power_up.instantiate() as PowerUp
	var instance_available_timer = instance.get_node("AvailableTimer") as Timer

	instance.position = Vector2(
		randf_range(spawn_area_start.x, spawn_area_end.x),
		randf_range(spawn_area_start.y, spawn_area_end.y),
	)

	instance.picked.connect(_on_power_up_picked)
	instance_available_timer.start()

	$AvailablePowerUps.add_child(instance)

func _on_spawn_timer_timeout():
	spawn(power_ups[randi_range(0, power_ups.size() - 1)])
	$SpawnCooldownTimer.start()

func _on_spawn_cooldown_timer_timeout():
	$SpawnTimer.start()

func _on_power_up_picked(power_up: PowerUp):
	var control = _power_up_control.instantiate()
	control.custom_minimum_size = Vector2(64, 64)

	power_up.position = Vector2(32, 32)
	power_up.name = "PowerUp"
	power_up.reparent(control, false)

	if %Ball.last_hit_by == %Player:
		power_up.effect_timeout.connect(_on_power_up_effect_timeout.bind( %Player))
		_player_picked_area.add_child(control)
	elif %Ball.last_hit_by == %Enemy:
		power_up.effect_timeout.connect(_on_power_up_effect_timeout.bind( %Enemy))
		_enemy_picked_area.add_child(control)

func _on_power_up_effect_timeout(power_up: PowerUp, target: Paddle):
	power_up.remove_effect(target)
	power_up.get_parent().queue_free()
