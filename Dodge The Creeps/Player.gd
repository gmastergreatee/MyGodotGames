extends Area2D

signal hit

export (int) var SPEED = 400;
var velocity = Vector2()
var screenSize = Rect2()

func _ready():
	screenSize = get_viewport_rect().size
	hide()
	pass

func _process(delta):
	velocity = Vector2()

	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		$AnimatedSprite.play()
		velocity = velocity.normalized() * SPEED
		$AnimatedSprite.flip_h = velocity.x < 0
		$AnimatedSprite.flip_v = velocity.y > 0
	else:
		$AnimatedSprite.stop()

	position += velocity * delta
	position.x = clamp(position.x, 0, screenSize.x)
	position.y = clamp(position.y, 0, screenSize.y)

	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
		$AnimatedSprite.animation = "up"
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		$AnimatedSprite.animation = "right"

	pass

func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	call_deferred("set_monitoring", false)
	pass

func start(pos: Vector2):
	position = pos
	show()
	monitoring = true
















