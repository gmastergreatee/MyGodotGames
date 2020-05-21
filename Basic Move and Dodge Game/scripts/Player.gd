extends KinematicBody

var velocity = Vector3(0,0,0)
export var Speed = 5;
export(float, 0, 1) var Damp = 0.1

func _ready() -> void:
	
	pass

func _physics_process(delta: float) -> void:
	
#	process inputs
	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right"):
		velocity.x = 0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -Speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = Speed
	else:
		velocity.x = lerp(velocity.x, 0, Damp)
	
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		velocity.z = 0
	elif Input.is_action_pressed("ui_up"):
		velocity.z = -Speed
	elif Input.is_action_pressed("ui_down"):
		velocity.z = Speed
	else:
		velocity.z = lerp(velocity.z, 0, Damp)
		
#	move the player
	move_and_slide(velocity)
	
#	fall down if goes outside
	if not is_on_floor():
		move_and_slide(Vector3(0, lerp(0, -Speed, 0.1), 0))















