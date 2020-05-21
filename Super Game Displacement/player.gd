extends RigidBody2D

export var Acceleration = 3000
export var MaxSpeed = 400

var reverse_compensation = 5
var directional_damp_factor = 0.95

func _ready() -> void:
	linear_damp = 2.3
	pass

func _physics_process(delta: float) -> void:
	if(Input.is_action_pressed("ui_left")):
		linear_velocity.x -= Acceleration * delta
		if(linear_velocity.x > 0):
			linear_velocity.x -= Acceleration * delta * reverse_compensation
		linear_velocity.y *= directional_damp_factor
		
	if(Input.is_action_pressed("ui_right")):
		linear_velocity.x += Acceleration * delta
		if(linear_velocity.x < 0):
			linear_velocity.x += Acceleration * delta * reverse_compensation
		linear_velocity.y *= directional_damp_factor
		
	if(Input.is_action_pressed("ui_up")):
		linear_velocity.y -= Acceleration * delta
		if(linear_velocity.y > 0):
			linear_velocity.y -= Acceleration * delta * reverse_compensation
		linear_velocity.x *= directional_damp_factor
		
	if(Input.is_action_pressed("ui_down")):
		linear_velocity.y += Acceleration * delta
		if(linear_velocity.y < 0):
			linear_velocity.y += Acceleration * delta * reverse_compensation
		linear_velocity.x *= directional_damp_factor
	
	linear_velocity.x = min(max(linear_velocity.x, -MaxSpeed), MaxSpeed)
	linear_velocity.y = min(max(linear_velocity.y, -MaxSpeed), MaxSpeed)
