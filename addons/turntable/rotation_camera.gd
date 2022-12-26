class_name RotationCamera

extends Camera

export var radius := 50
export var rotation_speed := 0.5
export var target := Vector3.ZERO

var _current_angle := 0.0


func _process(delta: float) -> void:
	_current_angle = fmod(_current_angle + delta * rotation_speed, 180)
	transform.origin = Vector3(
		radius * cos(_current_angle), (radius * 15.0) / 50.0, radius * sin(_current_angle)
	)
	look_at(target, Vector3.UP)
