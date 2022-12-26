extends Node

const RotationCamera = preload("res://addons/turntable/rotation_camera.gd")


func _ready():
	yield(get_tree().get_root(), "ready")
	
	var world_aabb = null
	
	# Check if there is already a camera in the scene
	var all_children = get_all_children(get_tree().get_root())
	for child in all_children:
		if child is Camera:
			return
		if child.is_class("VisualInstance"):
			var position = to_full_global(child, child.get_aabb().position)
			var end = to_full_global(child, child.get_aabb().end)
			
			if world_aabb == null:
				world_aabb = AABB(position, end - position)
			else:
				world_aabb.expand(position)
				world_aabb.expand(end)
	
	if world_aabb != null:
		# If there is no camera, create a new one and add it to the scene
		var camera = RotationCamera.new()
		get_tree().get_root().call_deferred("add_child", camera)
		camera.name = "camera"
		
		camera.target = world_aabb.get_center()
		print(camera.target)
		
		camera.radius = world_aabb.size.y
		print(camera.radius)


func get_all_children(in_node: Node, arr := []):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child, arr)
	return arr


func to_full_global(node: Node, point: Vector3):
	var parent := node.get_parent()
	if not is_instance_valid(parent) or parent == get_tree().get_root():
		return point

	if parent.is_class("Spatial"):
		point = parent.to_global(point)

	return to_full_global(parent, point)
