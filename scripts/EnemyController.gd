class_name EnemyController

extends Paddle

@onready var game_manager = %GameManager
@onready var ball = %Ball

@export_category("Ball Pursuit")
@export var min_distance: float
@export var min_boost_distance: float

var _speed: float

func _physics_process(delta):
	if game_manager.game_state != game_manager.GameStates.Running:
		return

	var dir = Vector2.ZERO

	if ball.dir.x > 0:
		if ball.position.y > position.y + min_distance:
			dir += Vector2.DOWN

		if ball.position.y < position.y - min_distance:
			dir += Vector2.UP
	else:
		var mid_point = get_viewport_rect().size.y / 2
		var target_point = mid_point

		if position.y < mid_point / 2:
			target_point = mid_point / 2
		elif position.y > mid_point / 2 and position.y < 1.5 * mid_point:
			target_point = mid_point
		else:
			target_point = 1.5 * mid_point

		if abs(target_point - position.y) <= _speed * delta:
			return

		if position.y > target_point:
			dir = Vector2.UP
		elif position.y < target_point:
			dir = Vector2.DOWN

	move_and_collide(dir * _speed * delta)

func _on_ready():
	_speed = base_speed
