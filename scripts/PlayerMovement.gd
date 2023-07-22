extends CharacterBody2D


const JUMP_HEIGHT = 3*16
const JUMP_RISE_TIME = 0.35
const JUMP_FALL_TIME = 0.25
const COYOTE_TIME = 0.1
const JUMP_BUFFER_TIME = 0.1
const MAX_FALL_SPEED = 640
const MAX_RUN_SPEED = 180
const RUN_START_TIME = 0.4
const RUN_STOP_TIME = 0.2

@onready var jump_velocity : float = -((2.0 * JUMP_HEIGHT) / JUMP_RISE_TIME)
@onready var jump_gravity : float = ((2.0 * JUMP_HEIGHT) / (JUMP_RISE_TIME * JUMP_RISE_TIME))
@onready var fall_gravity : float = ((2.0 * JUMP_HEIGHT) / (JUMP_FALL_TIME * JUMP_FALL_TIME))
@onready var run_accel : float = ((2.0 * MAX_RUN_SPEED) / (RUN_START_TIME * RUN_START_TIME))
@onready var run_decel : float = ((2.0 * MAX_RUN_SPEED) / (RUN_STOP_TIME * RUN_STOP_TIME))

var coyote = COYOTE_TIME
var jump_buffer = 0.0
var jumping = false


func _physics_process(delta: float) -> void:
	update_timers(delta)
	
	# switch gravity
	if velocity.y >= 0 or Input.is_action_just_released("jump"):
		jumping = false
	
	# fall
	velocity.y += get_gravity() * delta
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED
	
	# Handle Jump.
	if coyote > 0 or is_on_floor():
		if Input.is_action_just_pressed("jump") or jump_buffer > 0:
			jump()
	elif Input.is_action_just_pressed("jump"):
		jump_buffer = JUMP_BUFFER_TIME

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = move_toward(velocity.x, MAX_RUN_SPEED*direction, run_accel*delta)
	else:
		velocity.x = move_toward(velocity.x, 0, run_decel*delta)
	print(velocity.x)

	move_and_slide()


func get_gravity() -> float:
	return jump_gravity if jumping else fall_gravity


func jump():
	jumping = true
	velocity.y = jump_velocity
	coyote = 0
	jump_buffer = 0


func update_timers(delta: float) -> void:
	if not is_on_floor():
		if coyote > 0:
			coyote -= delta
	else:
		coyote = COYOTE_TIME
		
	if jump_buffer > 0:
		jump_buffer -= delta