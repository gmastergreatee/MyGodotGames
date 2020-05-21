extends KinematicBody

var velocity = Vector3(0,0,0)
export var Speed = 5;

func _ready() -> void:
	
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right"):
		velocity.x = 0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -Speed * delta
	elif Input.is_action_pressed("ui_right"):
		velocity.x = Speed * delta
	else:
		velocity.x = lerp(velocity.x, 0, 0.1)
	
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		velocity.z = 0
	elif Input.is_action_pressed("ui_up"):
		velocity.z = -Speed * delta
	elif Input.is_action_pressed("ui_down"):
		velocity.z = Speed * delta
	else:
		velocity.z = lerp(velocity.z, 0, 0.1)
		
	if not is_on_floor():
		velocity.y = -Speed * delta
	move_and_slide(velocity)















