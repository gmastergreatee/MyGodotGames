extends KinematicBody

var velocity = Vector3(0,0,0)
export var Speed = 5;
export var MaxSpeed = 200;
export(float, 0, 10) var Friction = 0.1
export(int, 1, 360) var RotateSpeed = 30;

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
#	process inputs
	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right"):
		velocity.x = reset_move(delta, velocity.x)
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= Speed * delta * Friction
		$MeshInstance.rotate_z(deg2rad(RotateSpeed))
	elif Input.is_action_pressed("ui_right"):
		velocity.x += Speed * delta * Friction
		$MeshInstance.rotate_z(-deg2rad(RotateSpeed))
	else:
		velocity.x = reset_move(delta, velocity.x)
	
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		velocity.z = reset_move(delta, velocity.z)
	elif Input.is_action_pressed("ui_up"):
		velocity.z -= Speed * delta * Friction
		$MeshInstance.rotate_x(-deg2rad(RotateSpeed))
	elif Input.is_action_pressed("ui_down"):
		velocity.z += Speed * delta * Friction
		$MeshInstance.rotate_x(deg2rad(RotateSpeed))
	else:
		velocity.z = reset_move(delta, velocity.z)
	
	velocity.x = max(min(velocity.x, MaxSpeed), -MaxSpeed)
	velocity.z = max(min(velocity.z, MaxSpeed), -MaxSpeed)
	
#	move the player
	velocity = move_and_slide(velocity, Vector3.UP)
	if not is_on_floor():
#		fall if not on floor
		velocity.y = -Speed
	

func reset_move(delta: float, vel: float) -> float:
	if vel != 0:
		vel = lerp(vel, 0, delta * Friction)
	return vel








