class_name TurntableCamera

extends Camera

export var radius := 10.0
export var rotation_speed := 0.5

# The point in world space, to rotate around
export var target_point := Vector3.ZERO

var _current_angle := 0.0


func _ready() -> void:
	set_as_toplevel(true)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_DOWN:
			radius = clamp(radius * 0.9, 5, 50)
		elif event.button_index == BUTTON_WHEEL_UP:
			radius = clamp(radius * 1.1, 5, 50)


func _process(delta: float) -> void:
	# Calculate the new position of the camera based on the angle and radius
	var x := target_point.x + radius * cos(_current_angle)
	var y := (radius * 15.0) / 50.0
	var z := target_point.z + radius * sin(_current_angle)
	var new_position := Vector3(x, y, z)

	# Set the camera's position and look at the target point
	set_global_transform(Transform(Basis.IDENTITY, new_position))
	look_at(target_point, Vector3.UP)

	# Increment the angle for the next frame
	_current_angle = fmod(_current_angle + delta * rotation_speed, 180)
