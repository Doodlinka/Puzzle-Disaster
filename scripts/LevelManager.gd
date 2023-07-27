extends Node2D

var level_root: Node

@export_file var first_level_path: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.load_level.connect(load_level)
	load_level(first_level_path)


func load_level(path: String) -> void:
	if is_instance_valid(level_root):
		level_root.queue_free()
	level_root = ResourceLoader.load(path).instantiate()
	self.add_child(level_root)
