extends Node

class Agent:
	var position: Vector3
	var direction: Vector3
	var length: int
	
	func _init(position_: Vector3, direction_: Vector3, length_: int):
		position = position_
		direction = direction_
		length = length_

export(NodePath) var lsystem_path
export(NodePath) var road_path
export(NodePath) var structure_path

export var road_length := 8

var length := 1

onready var road = get_node(road_path) as ProcCityRoad
onready var structure = get_node(structure_path) as ProcCityBuilding

# Called when the node enters the scene tree for the first time.
func _ready():
	print("visualizer ready")

	var lsystem = get_node(lsystem_path) as LSystem
	var sequence = lsystem.generate_sentence()
	
	print("sequence:", sequence)
	
	visualize_sequence(sequence)


func visualize_sequence(sequence: String):
	var ANGLE := 90
	
	var save_points := []
	
	var current_position := Vector3.ZERO
	var direction := Vector3.FORWARD
	
	for letter in sequence:
		match letter:
			'[':
				save_points.append(Agent.new(current_position, direction, length))
			']':
				var agent = save_points.pop_back()
				current_position = agent.position
				direction = agent.direction
				length = agent.length
			'F':
				road.place_street_positions(current_position, direction, length)
				current_position += direction * length
#				length -= 2
			'+':
				direction = direction.rotated(Vector3.UP, deg2rad(ANGLE))
			'-':
				direction = direction.rotated(Vector3.UP, deg2rad(-ANGLE))

	road.fix_road()
	structure.place_structures_around_road(road.get_road_positions())
