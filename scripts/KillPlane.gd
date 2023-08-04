extends Area2D


func _ready() -> void:
	area_entered.connect(call_reload)


func call_reload(_area) -> void:
	SignalBus.reload_level.emit()
