extends Label

@onready var game_manager = %GameManager

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = str(game_manager.enemy_score)
	pass
