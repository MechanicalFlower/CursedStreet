tool
extends EditorPlugin


func _enter_tree() -> void:
	if OS.is_debug_build():
		add_autoload_singleton("TurntableManager", "res://addons/turntable/turntable_manager.gd")


func _exit_tree() -> void:
	if OS.is_debug_build():
		remove_autoload_singleton("TurntableManager")
