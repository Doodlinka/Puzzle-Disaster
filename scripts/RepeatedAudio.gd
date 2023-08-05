extends AudioStreamPlayer


@export var min_pitch: float
@export var max_pitch: float
@export var time_between: float

var time_to_next := 0.0
var repeating := autoplay


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if time_to_next > 0:
		time_to_next -= delta
	
	if repeating and time_to_next <= 0:
		play()
		time_to_next = time_between
	

func play_repeat(from_position: float = 0.0) -> void:
	if not repeating:
		repeating = true
		time_to_next = 0
		play(from_position)

func stop_repeat() -> void:
	if repeating:
		repeating = false
		stop()
