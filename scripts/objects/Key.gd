extends Pickup


@onready var audio := $AudioStreamPlayer
@onready var collision_shape := $CollisionShape2D
@onready var sprite := $Sprite2D


func set_picked_up(value := true) -> void:
	super.set_picked_up(value)
	collision_shape.set_deferred("disabled", value)
	sprite.visible = not value
	SignalBus.set_key.emit(value)
	if value:
		audio.play()
