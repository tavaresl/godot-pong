extends CharacterBody2D

const treshold = 32
const speed = 256
@export var ball: CharacterBody2D

func _physics_process(delta):
	var dir = Vector2.ZERO
	
	if ball.position.y > position.y + treshold:
		dir += Vector2.DOWN
	
	if ball.position.y < position.y - treshold:
		dir += Vector2.UP
	
	move_and_collide(dir * speed * delta)
