extends Area2D


var current_interactable : Interactable


func _ready() -> void:
	self.area_entered.connect(on_area_enter)
	self.area_exited.connect(on_area_exit)
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if is_instance_valid(current_interactable):
			current_interactable.interact()
	
	
func on_area_enter(area: Area2D) -> void:
	if area is Interactable:
		current_interactable = area


func on_area_exit(area: Area2D) -> void:
	if area == current_interactable:
		current_interactable = null
