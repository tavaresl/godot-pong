@tool

extends EditorPlugin

func _enter_tree():
	add_custom_type("Resetter", "Node", preload ("res://addons/resetter_node/ResetterNode.gd"), preload ("res://icon.svg"))

func _exit_tree():
	remove_custom_type("Resetter")
