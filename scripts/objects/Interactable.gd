extends Area2D
class_name Interactable


const INTERACT_LAYER = 0b100 #3rd
const PLAYER_LAYER = 0b10 #2nd


func _ready() -> void:
	collision_layer |= INTERACT_LAYER
	collision_mask |= PLAYER_LAYER


func interact() -> void:
	pass
