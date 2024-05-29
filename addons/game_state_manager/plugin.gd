@tool

class_name GameStateManagerPlugin

extends EditorPlugin

func _enter_tree():
	add_custom_type("GameStateController", "Node", preload ("res://addons/game_state_manager/GameStateManager.gd"), preload ("res://icon.svg"))
	add_autoload_singleton("GameStateManager", "res://addons/game_state_manager/game_state_manager.tscn")

func _exit_tree():
	remove_custom_type("GameStateController")
	remove_autoload_singleton("GameStateManager")
