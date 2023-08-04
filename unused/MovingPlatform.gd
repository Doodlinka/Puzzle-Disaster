extends PathFollow2D


@export var speed := 100

var save_data := {}
var moving := false
var direction = 1


func _ready() -> void:
	get_node("../AnimatableBody2D/Area2D").area_entered.connect(on_area_stepped)
	SignalBus.save_state.connect(on_save_state)
	SignalBus.load_state.connect(on_load_state)


func _physics_process(delta: float) -> void:
	if not moving: return
	progress += direction * speed * delta
	if progress_ratio == 1 or progress_ratio == 0:
		moving = false
		direction = -direction


func on_area_stepped(_area):
	moving = true


func on_save_state() -> void:
	save_data.moving = moving
	save_data.direction = direction
	save_data.progress = progress

func on_load_state() -> void:
	moving = save_data.moving
	direction = save_data.direction
	progress = save_data.progress
