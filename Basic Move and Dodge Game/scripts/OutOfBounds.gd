extends Area

onready var player = get_node('../Player')

func _ready() -> void:
	pass

func _on_OutOfBounds_body_entered(body: Node) -> void:
	if body == player:
		player.resetPosition = true
