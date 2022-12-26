extends Node

const TurntableCamera = preload("res://addons/turntable/turntable_camera.gd")


func _ready():
	# Wait until all the nodes are ready before continuing
	yield(get_tree().get_root(), "ready")

	# Create a empty AABB
	var world_aabb := AABB(Vector3.ZERO, Vector3.ZERO)

	# Retrieve all children of the root node and store them in an array
	var all_children := get_all_children(get_tree().get_root())

	# Iterate over all the objects in the scene
	for child in all_children:

		# Check if there is already a camera in the scene
		if child is Camera:
			# If yes, no need to continue
			return

		# Check if the node is a VisualInstance
		if child.is_class("VisualInstance"):
			var aabb := child.get_aabb() as AABB

			# Convert coordinate to world space
			var transform = child.get_global_transform()
			var position = transform.xform(aabb.position)
			var end = transform.xform(aabb.end)

			# Expand the AABB
			world_aabb = world_aabb.expand(position)
			world_aabb = world_aabb.expand(end)

	# If there is no camera, create a new one and add it to the scene
	var camera := TurntableCamera.new()
	camera.target_point = world_aabb.get_center()
	get_tree().get_root().call_deferred("add_child", camera)


func get_all_children(in_node: Node, arr := []) -> Array:
	"""
	Recursively retrieves all children of a given Node and stores them in an array.
	"""
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child, arr)
	return arr
