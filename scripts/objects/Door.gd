extends Interactable


@export_file var level_path: String
@export var keys_required: int = 1


func _ready() -> void:
	SignalBus.set_key.connect(get_key)


func get_key() -> void:
	keys_required -= 1


func interact() -> void:
	super.interact()
	if keys_required <= 0:
		# insert unlock animation here
		SignalBus.load_level.emit(level_path)
