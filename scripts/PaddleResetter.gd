extends Node

@onready var _parent = get_parent()

# var _initial_position = Vector2.ZERO
var _initial_scale = Vector2.ZERO
var _initial_rotation = 0.0
var _initial_skew = 0.0
var _initial_speed = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	# _initial_position = _parent.position
	_initial_scale = _parent.scale
	_initial_rotation = _parent.rotation
	_initial_skew = _parent.skew
	_initial_speed = _parent.base_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	# _parent.position = _initial_position
	_parent.scale = _initial_scale
	_parent.rotation = _initial_rotation
	_parent.skew = _initial_skew
	_parent.speed = _initial_speed
