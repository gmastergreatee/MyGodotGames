extends RigidBody2D

export (int) var minSpeed = 150
export (int) var maxSpeed = 250
var mob_types = ["fly", "swim", "walk"]

func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
