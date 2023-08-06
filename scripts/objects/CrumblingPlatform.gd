extends StaticBody2D


@onready var timer := $Timer
@onready var collision_shape := $CollisionShape2D
@onready var area := $Area2D
@onready var sprite := $NinePatchRect
@onready var audio := $AudioStreamPlayer
var image1 := preload("res://sprites/objects/crumble1.png")
var image2 := preload("res://sprites/objects/crumble2.png")

var save_data := {}
var crumbled := false


func _ready() -> void:
	SignalBus.save_state.connect(on_save_state)
	SignalBus.load_state.connect(on_load_state)
	area.area_entered.connect(start_timer)
	timer.timeout.connect(set_disabled)


func start_timer(_area) -> void:
	if timer.is_stopped():
		sprite.texture = image2
		timer.start()
		audio.play(0)


func on_save_state() -> void:
	save_data.time = timer.time_left
	save_data.stopped = timer.is_stopped()
	save_data.crumbled = crumbled
	save_data.audio_time = audio.get_playback_position()
	
	
func on_load_state() -> void:
	if save_data.is_empty():
		return
	set_disabled(save_data.crumbled)
	if save_data.stopped:
		if not crumbled:
			if area.has_overlapping_areas():
				sprite.texture = image2
				timer.start(save_data.time)
				audio.play(save_data.audio_time)
			else:
				sprite.texture = image1
				timer.stop()
				audio.stop()
	else:
		timer.start(save_data.time)
		audio.play(save_data.audio_time)


func set_disabled(value := true) -> void:
	crumbled = value
	collision_shape.set_deferred("disabled", value)
	area.monitoring = not value
	sprite.visible = not value
