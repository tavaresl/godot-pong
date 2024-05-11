extends CharacterBody2D

@onready var game_manager = %GameManager
@onready var ball = %Ball
@export var speed = 400

const treshold = 32

func _physics_process(delta):
	if game_manager.game_state != game_manager.GameStates.Running:
		return

	var dir = Vector2.ZERO

	if ball.dir.x > 0:
		if ball.position.y > position.y + treshold:
			dir += Vector2.DOWN

		if ball.position.y < position.y - treshold:
			dir += Vector2.UP
	else:
		var mid_point = get_viewport_rect().size.y / 2

		if position.y > mid_point:
			dir = Vector2.UP
		elif position.y < mid_point:
			dir = Vector2.DOWN

	move_and_collide(dir * speed * delta)
