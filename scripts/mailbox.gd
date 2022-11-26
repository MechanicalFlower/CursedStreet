class_name Mailbox

extends Interactable

onready var target_camera = get_node("Camera")
onready var tween = get_node("%Tween") as Tween


func _ready():
	connect("interacted", self, "_on_Mailbox_interacted")


func _on_Mailbox_interacted(player, _item):
	GameManager.set_game_mode(GameManager.GameMode.DETAILED_INTERACTION)

	# Transform player camera to have a "detailed" interaction with the mailbox
	var camera = player.get_node("Head/Camera")
	zoom(camera, target_camera)


func zoom(camera_from: Camera, camera_to: Camera):
	var transform_from := camera_from.global_transform
	var transform_to := camera_to.global_transform
	tween.interpolate_property(
		camera_from,
		"global_transform",
		transform_from,
		transform_to,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
	)
	tween.start()
	camera_to.current = true
