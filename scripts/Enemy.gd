extends CharacterBody2D

@onready var game_manager = %GameManager

const treshold = 32
const speed = 256
@export var ball: CharacterBody2D

func _physics_process(delta):
	if game_manager.game_state != game_manager.GameStates.Running:
		return

	var dir = Vector2.ZERO
	
	if ball.position.y > position.y + treshold:
		dir += Vector2.DOWN

	if ball.position.y < position.y - treshold:
		dir += Vector2.UP
	
	move_and_collide(dir * speed * delta)
