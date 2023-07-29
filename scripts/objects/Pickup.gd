extends Area2D
class_name Pickup


const FOR_PLAYER_LAYER = 0b100 #3rd
const PLAYER_LAYER = 0b10 #2nd

var picked_up := false


func _ready() -> void:
	collision_layer |= FOR_PLAYER_LAYER
	collision_mask |= PLAYER_LAYER


func pick_up() -> void:
	picked_up = true
