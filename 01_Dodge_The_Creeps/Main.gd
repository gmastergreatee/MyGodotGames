extends Node2D

export (PackedScene) var Mob
var score

func _ready():
	randomize()
	pass

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func game_over():
	$ScoreTimer.stop()
	$MobTimer.start()
	pass


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	pass


func _on_ScoreTimer_timeout():
	score += 1
	pass


func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance();
	add_child(mob)

	var direction = $MobPath/MobSpawnLocation.rotation
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(mob.minSpeed, mob.maxSpeed), 0).rotated(direction))

	pass










