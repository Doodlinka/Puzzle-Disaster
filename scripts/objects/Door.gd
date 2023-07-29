extends Interactable


@export_file var level_path: String

var has_key := false


func _ready() -> void:
	SignalBus.set_key.connect(get_key)


func get_key() -> void:
	has_key = true


func interact() -> void:
	super.interact()
	if has_key:
		# insert unlock animation here
		SignalBus.load_level.emit(level_path)
