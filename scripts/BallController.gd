extends CharacterBody2D

const speed = 800
var dir = Vector2.from_angle(15)

func _physics_process(delta):
	var displacement = dir * speed * delta
	var collision = move_and_collide(displacement)
	
	if collision:
		var normal = collision.get_normal()
		var collider_name = collision.get_collider().name
		
		if collider_name != "Wall":
			var vertical_dir = Vector2(0, dir.y).normalized()
			var horizontal_dir = Vector2(dir.x, 0).normalized()
			var paddle_position = (collision.get_collider() as Node).position
			var diff = paddle_position.y - position.y

			if abs(diff) < 8:
				normal = normal.rotated(-vertical_dir.x * -vertical_dir.y * 0)
			elif abs(diff) < 16:
				normal = normal.rotated(-vertical_dir.x * -vertical_dir.y * 5)
			elif abs(diff) < 32:
				normal = normal.rotated(-vertical_dir.x * -vertical_dir.y * 10)
			else:
				normal = normal.rotated(-vertical_dir.x * -vertical_dir.y * 15)
			
		dir = dir.bounce(normal)



func _on_goal_body_entered(body):
	
	
	pass # Replace with function body.
