extends KinematicBody

var velocity = Vector3(0,0,0)
export var Speed = 5;
export var MaxSpeed = 200;
export(float, 0, 10) var Friction = 0.1
export(int, 1, 360) var RotateSpeed = 30;
var resetPosition = false
var allowInputs = true;

var rot_x = 0
var rot_z = 0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
#	re-spawning code
	if resetPosition:
		allowInputs = true;
		velocity = Vector3.ZERO
		set_translation(Vector3(0, 1, 0))
		$MeshInstance.set_rotation(Vector3(0, 0, 0))
		resetPosition = false
		return
	
	if allowInputs:
		var rotationRad = deg2rad(RotateSpeed)
	#	process inputs
		if Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right"):
			velocity.x = reset_move(delta, velocity.x)
			rot_z = 0
		elif Input.is_action_pressed("ui_left"):
			velocity.x -= Speed * delta * Friction
			rot_z = 1
		elif Input.is_action_pressed("ui_right"):
			velocity.x += Speed * delta * Friction
			rot_z = -1
		else:
			velocity.x = reset_move(delta, velocity.x)
			rot_z = 0
		
		if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
			velocity.z = reset_move(delta, velocity.z)
			rot_x = 0
		elif Input.is_action_pressed("ui_up"):
			velocity.z -= Speed * delta * Friction
			rot_x = -1
		elif Input.is_action_pressed("ui_down"):
			velocity.z += Speed * delta * Friction
			rot_x = 1
		else:
			velocity.z = reset_move(delta, velocity.z)
			rot_x = 0
		
#		handle rotation
		if rot_x != 0:
			$MeshInstance.rotate_x(rot_x * rotationRad)
		if rot_z != 0:
			$MeshInstance.rotate_z(rot_z * rotationRad)
		
		velocity.x = max(min(velocity.x, MaxSpeed), -MaxSpeed)
		velocity.y = -MaxSpeed
		velocity.z = max(min(velocity.z, MaxSpeed), -MaxSpeed)
	else:
		velocity.x = lerp(velocity.x, 0, delta * Friction/3)
		velocity.y = -Speed;
		velocity.z = lerp(velocity.z, 0, delta * Friction/3)
#		lerp through current rotation
		if rot_x != 0:
			var lim_x = 0.01
			if rot_x < 0:
				lim_x *= -1
			rot_x = lerp(rot_x, lim_x, 0.05)
			$MeshInstance.rotate_x(deg2rad(RotateSpeed * rot_x))
		if rot_z != 0:
			var lim_z = 0.01
			if rot_z < 0:
				lim_z *= -1
			rot_z = lerp(rot_z, lim_z, 0.05)
			$MeshInstance.rotate_z(deg2rad(RotateSpeed * rot_z))
	
#	move the player
	velocity = move_and_slide(velocity, Vector3.UP)
	if not is_on_floor():
#		lock movement
		allowInputs = false
	

func reset_move(delta: float, vel: float) -> float:
	if vel != 0:
		vel = lerp(vel, 0, delta * Friction)
	return vel
