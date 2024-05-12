extends PhysicsBody2D

@onready var game_manager = %GameManager
@export var base_speed = 400

var speed = base_speed
var direction = Vector2.ZERO

func _physics_process(delta: float):
	if game_manager.game_state != game_manager.GameStates.Running:
		return

	direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		direction += Vector2.UP
		
	if Input.is_action_pressed("ui_down"):
		direction += Vector2.DOWN

	var movement = direction.normalized() * speed * delta
	move_and_collide(movement)

func boost_speed(boost_rate: float):
	speed = base_speed * boost_rate
