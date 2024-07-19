extends RigidBody3D

# Adjustable parameters
@export var wheel_radius: float = 0.5

# Rotation angle
var rotation_angle: float = 0.0

func _physics_process(delta: float) -> void:
	# Simulate wheel rotation
	var distance_traveled = linear_velocity.length() * delta
	rotation_angle += distance_traveled / wheel_radius
	for child in get_children():
		if child is MeshInstance3D:
			child.rotate_x(rotation_angle)
