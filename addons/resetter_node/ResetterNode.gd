@tool

extends Node

@export var properties: Array[String] = []

var _initial_values = {}

func _enter_tree():
	pass

func _ready():
	if Engine.is_editor_hint():
		return

	var parent = get_parent()

	for property in properties:
		_initial_values[property] = _get_property_value(parent, property)

func _process(delta):
	if Engine.is_editor_hint():
		return

	var parent = get_parent()

	for property in _initial_values:
		_reset_property(parent, property, _initial_values[property])

static func _get_property_value(target: Variant, property: String):
	if property.find('.') > - 1:
		return _get_property_value(target[property.get_slice('.', 0)], property.get_slice('.', 1))

	return target[property]

static func _reset_property(target: Variant, property: String, value: Variant):
	if property.find('.') > - 1:
		return _reset_property(target[property.get_slice('.', 0)], property.get_slice('.', 1), value)

	target[property] = value
