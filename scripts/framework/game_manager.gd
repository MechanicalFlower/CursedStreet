extends Node

signal game_mode_changed(new_game_mode)

enum GameMode {
	NONE,
	EXPLORING,
	INTERACTION,
	DETAILED_INTERACTION,
	SETTINGS,
}

export(GameMode) var game_mode = GameMode.EXPLORING setget set_game_mode

var Balloon: PackedScene = preload("res://scenes/pixel_balloon.tscn")


func set_game_mode(new_game_mode):
	# Usually game mode change is a result of user input (e.g. pressing Tab),
	# and that input shouldn't cause further game mode changes
	get_tree().set_input_as_handled()
	game_mode = new_game_mode
	emit_signal("game_mode_changed", game_mode)


func show_dialogue(key: String, dialogue_resource: Resource) -> void:
	var dialogue = yield(dialogue_resource.get_next_dialogue_line(key), "completed")
	if dialogue != null:
		var balloon = Balloon.instance()
		balloon.dialogue = dialogue
		get_tree().current_scene.add_child(balloon)
		show_dialogue(yield(balloon, "actioned"), dialogue_resource)
