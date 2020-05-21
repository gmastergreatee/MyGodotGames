extends RigidBody2D

var speed = 500
export var maxSpeed = 200
onready var player:RigidBody2D = get_node("../player")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var movement_vector = (player.position - position).normalized()
	linear_velocity += movement_vector * speed * delta
	
	linear_velocity.x = max(min(linear_velocity.x, maxSpeed), -maxSpeed)
	linear_velocity.y = max(min(linear_velocity.y, maxSpeed), -maxSpeed)
	
