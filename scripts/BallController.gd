extends CharacterBody2D

@onready var game_manager = %GameManager
var speed = 400
var dir = Vector2.LEFT.rotated(deg_to_rad(7.5))

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
			var angle = deg_to_rad(remap(abs(diff), 0, paddle_sprite.scale.y / 2, 0, 30))
			var sign = normal.x * diff / abs(diff) if diff != 0 else 1

			var direction = normal.rotated(sign * angle)
			var incoming_dir = Vector2(dir)

			if incoming_dir.y < 0 and diff > 0:
				direction = dir.bounce(Vector2.DOWN)
			if incoming_dir.y > 0 and diff < 0:
				direction = dir.bounce(Vector2.UP)

			dir = direction
		else:
			dir = dir.bounce(normal)

func reset():
	dir = Vector2.LEFT.rotated(deg_to_rad(7.5))
	speed = 800
	position.x = 960
	position.y = 540


func _on_ready():
	pass # Replace with function body.
