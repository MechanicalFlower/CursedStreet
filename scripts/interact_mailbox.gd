class_name InteractMailbox

extends Interactable


var _zoomed_player = null
var _zoomed_player_head = null
var _initial_player_transform = Transform.IDENTITY
var _initial_player_head_rotation = Vector3.ZERO

onready var target_player: Spatial = get_node("%PlayerPoint")
onready var target_head: Spatial = get_node("%HeadPoint")
onready var tween: Tween = get_node("%Tween")


func _ready():
	connect("interacted", self, "_on_Mailbox_interacted")


func _process(_delta):
	if GameManager.game_mode != GameManager.GameMode.DETAILED_INTERACTION:
		return

	if Input.is_action_just_pressed("ui_cancel") and _zoomed_player != null and _zoomed_player_head != null:

		player_zoom(_initial_player_transform, _initial_player_head_rotation)

		GameManager.set_game_mode(GameManager.GameMode.EXPLORING)

		_zoomed_player = null
		_zoomed_player_head = null


func _on_Mailbox_interacted(player, _item):
	GameManager.set_game_mode(GameManager.GameMode.DETAILED_INTERACTION)

	var player_head = player.get_node("Head")

	_zoomed_player = player
	_zoomed_player_head = player_head
	_initial_player_transform = _zoomed_player.global_transform
	_initial_player_head_rotation = _zoomed_player_head.rot

	# Transform player head to have a "detailed" interaction with the mailbox
	player_zoom(target_player.global_transform, target_player.rotation)


func player_zoom(transform_to: Transform, rotation_to: Vector3):

	# move player to the player_point_target
	tween.interpolate_property(
		_zoomed_player,
		"global_transform",
		_zoomed_player.global_transform,
		transform_to,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
	)

	# and update his rotation head with set_rot, to ensure no cut after interaction
	tween.interpolate_method(
		_zoomed_player_head,
		"set_rot",
		_zoomed_player_head.rot,
		rotation_to,
		0.5,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
	)

	tween.start()
