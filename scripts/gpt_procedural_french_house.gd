extends Node

# Declare constants for the dimensions of the house
const WIDTH = 10
const LENGTH = 15
const HEIGHT = 5


func _ready():
	# Create a root node for the house
	var house = Spatial.new()

	# Create a MeshInstance to display the house
	var house_mesh = MeshInstance.new()

	# Create an ArrayMesh to store the house mesh
	var array_mesh = ArrayMesh.new()

	# Create a PoolVector3Array to store the vertices of the house
	var vertices = PoolVector3Array()

	# Add the vertices for the floor of the house
	vertices.append(Vector3(-WIDTH/2, 0, -LENGTH/2))
	vertices.append(Vector3(-WIDTH/2, 0, LENGTH/2))
	vertices.append(Vector3(WIDTH/2, 0, LENGTH/2))
	vertices.append(Vector3(WIDTH/2, 0, -LENGTH/2))

	# Add the vertices for the walls of the house
	vertices.append(Vector3(-WIDTH/2, 0, -LENGTH/2))
	vertices.append(Vector3(-WIDTH/2, 0, LENGTH/2))
	vertices.append(Vector3(-WIDTH/2, HEIGHT, LENGTH/2))
	vertices.append(Vector3(-WIDTH/2, HEIGHT, -LENGTH/2))
	vertices.append(Vector3(WIDTH/2, 0, -LENGTH/2))
	vertices.append(Vector3(WIDTH/2, 0, LENGTH/2))
	vertices.append(Vector3(WIDTH/2, HEIGHT, LENGTH/2))
	vertices.append(Vector3(WIDTH/2, HEIGHT, -LENGTH/2))
	vertices.append(Vector3(-WIDTH/2, 0, LENGTH/2))
	vertices.append(Vector3(-WIDTH/2, HEIGHT, LENGTH/2))
	vertices.append(Vector3(WIDTH/2, HEIGHT, LENGTH/2))
	vertices.append(Vector3(WIDTH/2, 0, LENGTH/2))
	vertices.append(Vector3(WIDTH/2, 0, -LENGTH/2))
	vertices.append(Vector3(WIDTH/2, HEIGHT, -LENGTH/2))
	vertices.append(Vector3(-WIDTH/2, HEIGHT, -LENGTH/2))
	vertices.append(Vector3(-WIDTH/2, 0, -LENGTH/2))

	# Add the vertices for the roof of the house
	vertices.append(Vector3(-WIDTH/2, HEIGHT, -LENGTH/2))
	vertices.append(Vector3(-WIDTH/2, HEIGHT, LENGTH/2))
	vertices.append(Vector3(WIDTH/2, HEIGHT, LENGTH/2))
	vertices.append(Vector3(WIDTH/2, HEIGHT, -LENGTH/2))
	
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices

	# Set the vertices of the ArrayMesh
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)

	# Set the ArrayMesh of the MeshInstance
	house_mesh.mesh = array_mesh

	# Add the MeshInstance to the house node
	house.add_child(house_mesh)

	# Add a door and a window to the house
	var door = MeshInstance.new()
	door.mesh = ArrayMesh.new()

	# Create a PoolVector3Array to store the vertices of the door
	var door_vertices = PoolVector3Array()

	# Add vertices to the door_vertices array
	door_vertices.append(Vector3(-1, 0, 0))
	door_vertices.append(Vector3(-1, 2, 0))
	door_vertices.append(Vector3(1, 2, 0))
	door_vertices.append(Vector3(1, 0, 0))
	
	var door_arrays = []
	door_arrays.resize(ArrayMesh.ARRAY_MAX)
	door_arrays[ArrayMesh.ARRAY_VERTEX] = door_vertices

	# Set the vertices of the door mesh
	door.mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, door_arrays)

	# Rotate and translate the door to its correct position
	door.rotate(Vector3(0, 1, 0), 90)
	door.translate(Vector3(-WIDTH/2, 0, LENGTH/2))

	# Add the door to the house node
	house.add_child(door)

	var window = MeshInstance.new()
	window.mesh = ArrayMesh.new()

	# Create a PoolVector3Array to store the vertices of the window
	var window_vertices = PoolVector3Array()

	# Add vertices to the window_vertices array
	window_vertices.append(Vector3(-1, 0, 0))
	window_vertices.append(Vector3(-1, 1, 0))
	window_vertices.append(Vector3(1, 1, 0))
	window_vertices.append(Vector3(1, 0, 0))
	
	var window_arrays = []
	window_arrays.resize(ArrayMesh.ARRAY_MAX)
	window_arrays[ArrayMesh.ARRAY_VERTEX] = window_vertices

	# Set the vertices of the window mesh
	window.mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, window_arrays)

	# Rotate and translate the window to its correct position
	window.rotate(Vector3(0, 1, 0), 90)
	window.translate(Vector3(WIDTH/2, 2, -LENGTH/2))

	# Add the window to the house node
	house.add_child(window)
	
	add_child(house)
