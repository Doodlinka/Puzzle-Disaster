extends Node2D

var level_root: Node
var reset_root: Node

@export_file var first_level_path: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level(first_level_path)


func _process(_delta: float) -> void:
	if Input.is_physical_key_pressed(KEY_R):
		reset()
	if Input.is_physical_key_pressed(KEY_T):
		true_reload()


func load_level(path: String) -> void:
	level_root = ResourceLoader.load(path).instantiate()
	self.add_child(level_root)
	reset_root = get_node("./" + level_root.name + "/RESETABLE")


func true_reload() -> void:
	level_root.queue_free()
	load_level(level_root.scene_file_path)


func reset() -> void:
	if not is_instance_valid(reset_root):
		return
		
	reset_root.queue_free()
	var temp = ResourceLoader.load(level_root.scene_file_path).instantiate()
	reset_root = temp.get_node("./RESETABLE")
	temp.remove_child(reset_root)
	level_root.add_child(reset_root)
	temp.queue_free()
