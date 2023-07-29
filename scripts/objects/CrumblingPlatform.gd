extends StaticBody2D


@onready var timer := $Timer
@onready var collision_shape := $CollisionShape2D
@onready var area := $Area2D
@onready var sprite := $NinePatchRect

var save_data := {}
var crumbled := false


func _ready() -> void:
	SignalBus.save_state.connect(on_save_state)
	SignalBus.load_state.connect(on_load_state)
	area.area_entered.connect(start_timer)
	timer.timeout.connect(set_disabled)


func start_timer(_area) -> void:
	timer.start()


func on_save_state() -> void:
	save_data.time = timer.time_left
	save_data.stopped = timer.is_stopped()
	save_data.crumbled = crumbled
	
	
func on_load_state() -> void:
	if save_data.is_empty():
		return
	if save_data.stopped:
		timer.stop()
	else:
		timer.start(save_data.time)
	set_disabled(save_data.crumbled)


func set_disabled(value := true) -> void:
	crumbled = value
	collision_shape.set_deferred("disabled", value)
	area.monitoring = not value
	sprite.visible = not value
