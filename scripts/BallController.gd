extends CharacterBody2D

@onready var game_manager = %GameManager

@export var min_speed = 800
@export var max_speed = 1600
@export var initial_speed = 800
@export var booster_increase_rate = 0.05
var speed = 400
var speed_booster = 1
var dir = Vector2.LEFT.rotated(deg_to_rad(7.5))

func _on_ready():
	speed = initial_speed

func _physics_process(delta):
	if game_manager.game_state != game_manager.GameStates.Running:
		return

	var displacement = dir * speed * delta
	var collision = move_and_collide(displacement)

	if collision:
		var normal = collision.get_normal()
		var collider_name = collision.get_collider().name

		if not ["Top", "Bottom"].has(collider_name):
			var paddle_position = collision.get_collider().position
			var paddle_sprite: Sprite2D = collision.get_collider().get_node("Sprite2D")

			var diff = position.y - paddle_position.y
			var angle = remap(abs(diff), 0, paddle_sprite.scale.y / 2, 0, 30)
			var op_sign = normal.x * diff / abs(diff) if diff != 0 else 1
			
			speed_booster += booster_increase_rate
			speed = remap(angle, 0, 30, min_speed, max_speed) * speed_booster

			var direction = normal.rotated(op_sign * deg_to_rad(angle))
			var incoming_dir = Vector2(dir)

			if incoming_dir.y < 0 and diff > 0:
				direction = dir.bounce(Vector2.DOWN)
			if incoming_dir.y > 0 and diff < 0:
				direction = dir.bounce(Vector2.UP)

			dir = direction
		else:
			dir = dir.bounce(normal)

func reset():
	var op_sign = -(dir.y / abs(dir.y))
	var angle = deg_to_rad(op_sign * 7.5)

	if dir.x < 0:
		dir = Vector2.RIGHT.rotated(angle)
	elif dir.x > 0:
		dir = Vector2.LEFT.rotated(angle)

	speed = initial_speed
	speed_booster = 1
	position.x = 960
	position.y = 540
