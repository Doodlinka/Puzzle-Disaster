extends Pickup


@onready var audio := $AudioStreamPlayer
@onready var collision_shape := $CollisionShape2D
@onready var sprite := $Sprite2D


func pick_up() -> void:
	super.pick_up()
	collision_shape.set_deferred("disabled", true)
	sprite.visible = false
	SignalBus.set_key.emit()
	audio.play()
