extends Node2D

var level_root: Node
var reset_root: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load(path: String) -> void:
	level_root = ResourceLoader.load(path).instantiate()
	reset_root = get_node("." + level_root.name + "/RESETABLE")
	self.add_child(level_root)
	

func true_reload() -> void:
	level_root = recreate(level_root)
	self.add_child(level_root)

func reset() -> void:
	reset_root = recreate(reset_root)
	level_root.add_child(reset_root)
	
func recreate(node: Node) -> Node:
	var new = node.duplicate()
	node.queue_free()
	return new
