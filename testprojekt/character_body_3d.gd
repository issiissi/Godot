extends CharacterBody3D

@export var SPEED = 1.0
@export var JUMP_VELOCITY = 4.5
@export var camera_pan_speed = 2
const PAN_SPEED_FACTOR = 0.00001

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jumping
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction * -1
	if direction:
		velocity.x = direction.x * SPEED 
		velocity.z = direction.z * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Mouse look (only horizontal rotation for the body)
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var mouse_vel = Input.get_last_mouse_velocity()

		rotation.y -= mouse_vel.x * camera_pan_speed * PAN_SPEED_FACTOR

		var cam_pitch = $camrearig.rotation.x - mouse_vel.y * camera_pan_speed * PAN_SPEED_FACTOR
		cam_pitch = clamp(cam_pitch, -PI/2, -PI/8)
		$camrearig.rotation.x = cam_pitch

		# Allow toggling mouse mode
		if Input.is_action_just_pressed("ui_cancel"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		if Input.is_action_just_pressed("ui_cancel"):
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	move_and_slide()
	
	var collision = move_and_collide(velocity * delta)
	if collision and collision.get_collider() is RigidBody3D:
		var rb = collision.get_collider() as RigidBody3D
		var impulse = velocity * rb.mass * 4  # anpassen je nach gewünschter Kraft
		rb.apply_central_impulse(impulse)	
