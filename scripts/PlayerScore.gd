extends Label

@onready var game_manager = %GameManager

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(game_manager.player_score)
	pass
