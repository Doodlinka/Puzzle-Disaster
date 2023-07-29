extends Area2D
class_name Pickup


const FOR_PLAYER_LAYER = 0b100 #3rd
const PLAYER_LAYER = 0b10 #2nd

var picked_up := false
var save_data := {}


func _ready() -> void:
	collision_layer |= FOR_PLAYER_LAYER
	collision_mask |= PLAYER_LAYER
	SignalBus.save_state.connect(on_save_state)
	SignalBus.load_state.connect(on_load_state)


func on_save_state() -> void:
	save_data.picked_up = picked_up
	
	
func on_load_state() -> void:
	if save_data.is_empty():
		return
	set_picked_up(save_data.picked_up)


func set_picked_up(value := true) -> void:
	picked_up = value
