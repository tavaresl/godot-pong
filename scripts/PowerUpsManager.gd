extends Node

@export var spawn_area_start: Vector2 = Vector2(640, 320)
@export var spawn_area_end: Vector2 = Vector2(1280, 720)

@export var power_ups: Array[PackedScene] = [
	preload ("res://scenes/expand_power_up.tscn"),
]

@onready var _power_up_control = preload ("res://scenes/power_up_control.tscn")
@onready var _player_picked_area: HBoxContainer = $PlayerPowerUps/PowerUpsContainer
@onready var _enemy_picked_area: HBoxContainer = $EnemyPowerUps/PowerUpsContainer

var _player_effects: Array[PowerUp] = []
var _enemy_effects: Array[PowerUp] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for effect in _player_effects:
		effect.apply_effect( %Player)

	for effect in _enemy_effects:
		effect.apply_effect( %Enemy)

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
	var effects: Array[PowerUp] = []
	var container: HBoxContainer = null
	var target: Paddle = null
	control.custom_minimum_size = Vector2(64, 64)

	power_up.position = Vector2(32, 32)
	power_up.name = "PowerUp"
	power_up.reparent(control, false)

	if %Ball.last_hit_by == %Player:
		target = %Player
		effects = _player_effects
		container = _player_picked_area
	elif %Ball.last_hit_by == %Enemy:
		target = %Enemy
		effects = _enemy_effects
		container = _enemy_picked_area

	if container == null or target == null:
		return

	var matched_effects = effects.filter(func(e): return e.power_up_name == power_up.power_up_name)
	var existing_effect = matched_effects.front() if not matched_effects.is_empty() else null

	if existing_effect == null:
		power_up.effect_timeout.connect(_on_power_up_effect_timeout.bind(target))
		effects.append(power_up)
		container.add_child(control)
	else:
		existing_effect.get_node("EffectTimer").start()
		power_up.queue_free()

func _on_power_up_effect_timeout(power_up: PowerUp, target: Paddle):
	if target == %Player:
		_player_effects.remove_at(_player_effects.find(power_up))
	elif target == %Enemy:
		_enemy_effects.remove_at(_enemy_effects.find(power_up))

	#power_up.remove_effect(target)
	power_up.get_parent().queue_free()
