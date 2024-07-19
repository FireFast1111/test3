extends RigidBody3D

# References to the wheels
@onready var left_wheel = $LeftWheel
@onready var right_wheel = $RightWheel

# Adjustable parameters
@export var acceleration: float = 10.0
@export var max_speed: float = 50.0

func _physics_process(delta) -> void:
	# Handle input for movement
	if Input.is_action_pressed("ui_up"):
		left_wheel.apply_central_force(Vector3(0, 0, -acceleration))
		right_wheel.apply_central_force(Vector3(0, 0, -acceleration))
	
	if Input.is_action_pressed("ui_down"):
		left_wheel.apply_central_force(Vector3(0, 0, acceleration))
		right_wheel.apply_central_force(Vector3(0, 0, acceleration))
	
	# Handle input for steering
	if Input.is_action_pressed("ui_left"):
		left_wheel.apply_central_force(Vector3(0, 0, acceleration))
		right_wheel.apply_central_force(Vector3(0, 0, -acceleration))
	
	if Input.is_action_pressed("ui_right"):
		left_wheel.apply_central_force(Vector3(0, 0, -acceleration))
		right_wheel.apply_central_force(Vector3(0, 0, acceleration))
	
	# Limit speed for both wheels
	limit_speed(left_wheel, max_speed)
	limit_speed(right_wheel, max_speed)

func limit_speed(body: RigidBody3D, max_speed: float) -> void:
	var current_speed = body.linear_velocity.length()
	if current_speed > max_speed:
		body.linear_velocity = body.linear_velocity.normalized() * max_speed
