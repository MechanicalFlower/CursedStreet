const enums = preload("res://scripts/procedural_city/direction.gd")


static func find_neighbour(position: Vector3, collection: PoolVector3Array) -> Array:
	var neighbour_directions := []

	if (position + Vector3.RIGHT) in collection:
		neighbour_directions.append(enums.Direction.RIGHT)

	if (position + Vector3.LEFT) in collection:
		neighbour_directions.append(enums.Direction.LEFT)

	if (position + Vector3.FORWARD) in collection:
		neighbour_directions.append(enums.Direction.UP)

	if (position + Vector3.BACK) in collection:
		neighbour_directions.append(enums.Direction.DOWN)

	return neighbour_directions


static func get_offset_from_direction(direction: int) -> Vector3:
	match direction:
		enums.Direction.UP:
			return Vector3.FORWARD
		enums.Direction.DOWN:
			return Vector3.BACK
		enums.Direction.LEFT:
			return Vector3.LEFT
		enums.Direction.RIGHT:
			return Vector3.RIGHT
	return Vector3.ZERO


static func get_reverse_direction(direction: int) -> int:
	match direction:
		enums.Direction.UP:
			return enums.Direction.DOWN
		enums.Direction.DOWN:
			return enums.Direction.UP
		enums.Direction.LEFT:
			return enums.Direction.RIGHT
		enums.Direction.RIGHT:
			return enums.Direction.LEFT
	return -1
