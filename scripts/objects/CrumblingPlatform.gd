extends StaticBody2D


@onready var timer := $Timer
@onready var collision_shape := $CollisionShape2D
@onready var area := $Area2D
@onready var sprite := $AnimatedSprite2D

var save_data := {}
var crumbled := false


func _ready() -> void:
	SignalBus.save_state.connect(on_save_state)
	SignalBus.load_state.connect(on_load_state)
	area.area_entered.connect(start_timer)
	timer.timeout.connect(set_disabled)


func start_timer(_area) -> void:
	sprite.frame = 1
	timer.start()


func on_save_state() -> void:
	save_data.time = timer.time_left
	save_data.stopped = timer.is_stopped()
	save_data.crumbled = crumbled
	
	
func on_load_state() -> void:
	if save_data.is_empty():
		return
	set_disabled(save_data.crumbled)
	if save_data.stopped:
		if not crumbled:
			if area.has_overlapping_areas():
				sprite.frame = 1
				timer.start(save_data.time)
			else:
				sprite.frame = 0
				timer.stop()
	else:
		timer.start(save_data.time)


func set_disabled(value := true) -> void:
	crumbled = value
	collision_shape.set_deferred("disabled", value)
	area.monitoring = not value
	sprite.visible = not value
