extends Interactable


@export_file var level_path: String


func interact() -> void:
	super.interact()
	SignalBus.load_level.emit(level_path)
