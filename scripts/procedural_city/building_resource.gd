class_name BuildingResource

extends Resource

export(PackedScene) var building_node
export(int) var size_required
export(int) var quantity = 0

var quantity_already_place := 0


func get_scene() -> PackedScene:
	quantity_already_place += 1
	return building_node


func is_available() -> bool:
	return quantity_already_place < quantity
