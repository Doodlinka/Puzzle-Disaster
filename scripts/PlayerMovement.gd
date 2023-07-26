extends CharacterBody2D


const MAX_JUMP_HEIGHT = 4*16
const MIN_JUMP_HEIGHT = 16
const JUMP_RISE_TIME = 0.35
const JUMP_FALL_TIME = 0.25
const COYOTE_TIME = 0.15
const JUMP_BUFFER_TIME = 0.15
const MAX_FALL_SPEED = 400
const JUMP_HORIZ_VEL_MULT = 1.2

const MAX_RUN_SPEED = 180
const RUN_START_TIME = 0.4
const RUN_STOP_TIME = 0.2

const JUMP_VELOCITY : float = -((2.0 * MAX_JUMP_HEIGHT) / JUMP_RISE_TIME)
const VARJUMP_VELOCITY_CLAMP = -((2.0 * MIN_JUMP_HEIGHT) / JUMP_RISE_TIME)
const JUMP_GRAVITY : float = ((2.0 * MAX_JUMP_HEIGHT) / (JUMP_RISE_TIME * JUMP_RISE_TIME))
const FALL_GRAVITY : float = ((2.0 * MAX_JUMP_HEIGHT) / (JUMP_FALL_TIME * JUMP_FALL_TIME))
const RUN_ACCEL : float = ((2.0 * MAX_RUN_SPEED) / (RUN_START_TIME * RUN_START_TIME))
const RUN_DECEL : float = ((2.0 * MAX_RUN_SPEED) / (RUN_STOP_TIME * RUN_STOP_TIME))

var coyote = COYOTE_TIME
var jump_buffer = 0.0
var jumping = false
var previous_dir = 0


func _physics_process(delta: float) -> void:
	update_timers(delta)
	
	# switch gravity (if two gravities are in use)
	if velocity.y >= 0 or Input.is_action_just_released("jump"):
		jumping = false
	# variable jump
	if velocity.y < VARJUMP_VELOCITY_CLAMP and Input.is_action_just_released("jump"):
		velocity.y = VARJUMP_VELOCITY_CLAMP
	
	# fall
	if not is_on_floor():
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
	var direction := get_horiz_direction()
	if direction:
		velocity.x = move_toward(velocity.x, MAX_RUN_SPEED*direction, RUN_ACCEL*delta)
	else:
		velocity.x = move_toward(velocity.x, 0, RUN_DECEL*delta)

	move_and_slide()


func get_gravity() -> float:
	return JUMP_GRAVITY if jumping else FALL_GRAVITY


func jump():
	jumping = true
	velocity.y = JUMP_VELOCITY
	velocity.x *= JUMP_HORIZ_VEL_MULT
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


func get_horiz_direction() -> int:
	var l = Input.is_action_pressed("move_left")
	var r = Input.is_action_pressed("move_right")
	if l and r:
		return -previous_dir
	elif l:
		previous_dir = -1
		return -1
	elif r:
		previous_dir = 1
		return 1
	previous_dir = 0
	return 0
