extends Interactable

export var dialogue_resource: Resource

var first_visit = true


func _ready():
	DialogueManager.connect("dialogue_finished", self, "_on_MomDoor_dialogue_finished")
	connect("interacted", self, "_on_MomDoor_interacted")


func _on_MomDoor_interacted(_player, _item):
	GameManager.set_game_mode(GameManager.GameMode.INTERACTION)
	GameManager.show_dialogue("first_visit" if first_visit else "other", dialogue_resource)
	first_visit = false


func _on_MomDoor_dialogue_finished():
	yield(get_tree().create_timer(0.4), "timeout")
	GameManager.set_game_mode(GameManager.GameMode.EXPLORING)
