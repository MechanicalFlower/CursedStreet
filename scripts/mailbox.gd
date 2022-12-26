class_name Mailbox

extends Spatial

#var tween_values = [Vector3(-85, 90, -90), Vector3(-95, 90, -90)]

var shake = 0.0015
var shake_duration = 0.1

onready var tween = get_node("%ShakeTween") as Tween
#onready var mailbox = get_node(".")
onready var mailbox = get_node("Spatial")

#func _ready():
#	start_tween()


func _physics_process(_delta) -> void:
	if GameManager.game_mode != GameManager.GameMode.DETAILED_INTERACTION:
		return

	var input_axis = Input.get_vector("move_left", "move_right", "move_back", "move_forward")
	var direction = Vector3(input_axis.x, 0.0, input_axis.y)

	if direction != Vector3.ZERO:
		var shake_vector = Vector3(rand_range(0.0, shake), 0.0, rand_range(0.0, shake))

		tween.interpolate_property(mailbox, "translation", self.translation, direction * shake_vector, shake_duration)
		tween.start()


func _on_ShakeTween_completed(_object, _key):
	pass
