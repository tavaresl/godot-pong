extends PhysicsBody2D

@onready var game_manager = %GameManager
@export var speed = 400

func _physics_process(delta: float):
	if game_manager.game_state != game_manager.GameStates.Running:
		return

	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		direction += Vector2.UP
		
	if Input.is_action_pressed("ui_down"):
		direction += Vector2.DOWN
	
	var movement = direction.normalized() * speed * delta
	move_and_collide(movement)
