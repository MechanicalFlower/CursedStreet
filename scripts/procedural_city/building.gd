tool

class_name ProcCityBuilding

extends Node

const enums = preload("res://scripts/procedural_city/direction.gd")
const Placement = preload("res://scripts/procedural_city/placement.gd")

export(Array, Resource) var building_types
export(Array, PackedScene) var nature_nodes

export(bool) var random_nature_placement = false
export(float, 0, 1) var random_nature_placement_treshold = 0.3

var buildings := {}
var natures := {}

onready var _owner := get_parent() as Spatial


func place_structures_around_road(road_positions: PoolVector3Array):
	print(road_positions)
	var free_estate_spots := find_free_spaces_around_road(road_positions)
	var blocked_positions: PoolVector3Array = []

	for free_spot in free_estate_spots.keys():
		if free_spot in blocked_positions:
			continue

		var rotation := Vector3.ZERO
		match free_estate_spots[free_spot]:
			enums.Direction.UP:
				rotation = Vector3(0, -90, 0)
			enums.Direction.DOWN:
				rotation = Vector3(0, 90, 0)
			enums.Direction.RIGHT:
				rotation = Vector3(0, 0, 0)
			enums.Direction.LEFT:
				rotation = Vector3(0, 180, 0)

		for building_type in building_types:
			var building_resource := building_type as BuildingResource

			if random_nature_placement:
				if randf() < random_nature_placement_treshold:
					var nature_scene := nature_nodes[randi() % len(nature_nodes)] as PackedScene

					var nature := nature_scene.instance() as Spatial
					nature.set_rotation_degrees(rotation)
					nature.set_translation(free_spot)

					add_child(nature)
#					nature.set_owner(_owner)

					natures[free_spot] = nature
					break

			if building_type.is_available():
				if building_type.size_required > 1:
					var half_size = ceil(building_type.size_required / 2.0)

					var temp_blocked_positions: PoolVector3Array = []
					if verify_if_building_fits(half_size, free_estate_spots, free_spot, free_estate_spots[free_spot], temp_blocked_positions):
						blocked_positions.append_array(temp_blocked_positions)

						var building_scene := building_resource.get_scene()

						var building := building_scene.instance() as Spatial
						building.set_rotation_degrees(rotation)
						building.set_translation(free_spot)

						add_child(building)
#						building.set_owner(_owner)

						for position in temp_blocked_positions:
							buildings[position] = building
						break

				else:
					var building_scene := building_resource.get_scene()

					var building := building_scene.instance() as Spatial
					building.set_rotation_degrees(rotation)
					building.set_translation(free_spot)

					add_child(building)
#					building.set_owner(_owner)

					buildings[free_spot] = building
					break


func verify_if_building_fits(half_size: int, free_estats_sports: Dictionary, free_spot: Vector3, free_spot_direction: int, temp_blocked_positions: PoolVector3Array) -> bool:
	var direction := Vector3.ZERO
	if free_spot_direction == enums.Direction.DOWN or free_spot_direction == enums.Direction.UP:
		direction = Vector3.RIGHT
	else:
		direction = Vector3.BACK

	for i in range(half_size):
		var position_1 := free_spot + direction * i
		var position_2 := free_spot - direction * i

		if (not position_1 in free_estats_sports) or (not position_2 in free_estats_sports):
			return false

		temp_blocked_positions.append(position_1)
		temp_blocked_positions.append(position_2)

	return true


func find_free_spaces_around_road(road_positions: PoolVector3Array) -> Dictionary:
	var free_spaces := {}
	for position in road_positions:
		var neighbour_directions := Placement.find_neighbour(position, road_positions)
		for direction in [enums.Direction.UP, enums.Direction.DOWN, enums.Direction.LEFT, enums.Direction.RIGHT]:
			if not direction in neighbour_directions:
				var new_position := (position + Placement.get_offset_from_direction(direction)) as Vector3
				if new_position in free_spaces:
					continue
				free_spaces[new_position] = Placement.get_reverse_direction(direction)
	return free_spaces
