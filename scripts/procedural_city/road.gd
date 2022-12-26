class_name ProcCityRoad

extends Node

const enums = preload("res://scripts/procedural_city/direction.gd")
const Placement = preload("res://scripts/procedural_city/placement.gd")

export(PackedScene) var road_straight
export(PackedScene) var road_end
export(PackedScene) var road_corner
export(PackedScene) var road_3_way
export(PackedScene) var road_4_way

var roads := {}
var fix_road_candidates: PoolVector3Array = []

onready var _owner := get_parent() as Spatial


func get_road_positions() -> PoolVector3Array:
	return PoolVector3Array(roads.keys())


func place_street_positions(start_position: Vector3, direction: Vector3, length: int):
	for i in range(length):
		var position = start_position + direction * i

		if position in roads:
			continue

		var road = road_straight.instance() as Spatial
		road.set_translation(position)

		add_child(road)
#		road.set_owner(_owner)

		roads[position] = road

		if (i == 0 or i == (length - 1)) and not position in fix_road_candidates:
			fix_road_candidates.append(position)


func fix_road() -> void:
	for position in fix_road_candidates:
		var neightbour_directions := Placement.find_neighbour(position, get_road_positions())

		var rotation = Vector3.ZERO

		if len(neightbour_directions) == 1:
			roads[position].queue_free()

			if enums.Direction.DOWN in neightbour_directions:
				rotation = Vector3(0, 90, 0)
			elif enums.Direction.LEFT in neightbour_directions:
				rotation = Vector3(0, 180, 0)
			elif enums.Direction.UP in neightbour_directions:
				rotation = Vector3(0, -90, 0)

			var road = road_end.instance() as Spatial
			road.set_rotation_degrees(rotation)
			road.set_translation(position)

			add_child(road)
#			road.set_owner(_owner)

			roads[position] = road

		elif len(neightbour_directions) == 2:
			if (enums.Direction.UP in neightbour_directions and enums.Direction.DOWN in neightbour_directions) or \
			   (enums.Direction.LEFT in neightbour_directions and enums.Direction.RIGHT in neightbour_directions):
				continue

			roads[position].queue_free()

			if enums.Direction.UP in neightbour_directions and enums.Direction.RIGHT in neightbour_directions:
				rotation = Vector3(0, 90, 0)
			elif enums.Direction.RIGHT in neightbour_directions and enums.Direction.DOWN in neightbour_directions:
				rotation = Vector3(0, 180, 0)
			elif enums.Direction.DOWN in neightbour_directions and enums.Direction.LEFT in neightbour_directions:
				rotation = Vector3(0, -90, 0)

			var road = road_corner.instance() as Spatial
			road.set_rotation_degrees(rotation)
			road.set_translation(position)

			add_child(road)
#			road.set_owner(_owner)

			roads[position] = road

		elif len(neightbour_directions) == 3:
			roads[position].queue_free()

			if enums.Direction.RIGHT in neightbour_directions and enums.Direction.DOWN in neightbour_directions and enums.Direction.LEFT in neightbour_directions:
				rotation = Vector3(0, 90, 0)
			elif enums.Direction.DOWN in neightbour_directions and enums.Direction.LEFT in neightbour_directions and enums.Direction.UP in neightbour_directions:
				rotation = Vector3(0, 180, 0)
			elif enums.Direction.LEFT in neightbour_directions and enums.Direction.UP in neightbour_directions and enums.Direction.RIGHT in neightbour_directions:
				rotation = Vector3(0, -90, 0)

			var road = road_3_way.instance() as Spatial
			road.set_rotation_degrees(rotation)
			road.set_translation(position)

			add_child(road)
#			road.set_owner(_owner)

			roads[position] = road

		else:
			roads[position].queue_free()

			var road = road_4_way.instance() as Spatial
			road.set_rotation_degrees(rotation)
			road.set_translation(position)

			add_child(road)
#			road.set_owner(_owner)

			roads[position] = road
