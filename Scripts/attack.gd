extends State
class_name Attack

@export var enemy : CharacterBody2D
@export var move_speed : float = 100.0
@export var timer : Timer
var projectile_scene = preload("res://Scenes/bullet.tscn")
var dir = Vector2.ZERO
var target
func Enter():
	target = get_node("/root/Game/Player")
	if enemy and target:
		timer.start()
func Exit():
	if timer:
		timer.stop()
func Update(_delta: float) -> void:
	pass

func Physics_Update(_delta: float) -> void:
	if enemy and target:
		var enemy_pos = enemy.global_position
		var target_pos = target.global_position
		var diff = target_pos - enemy_pos

		var move = Vector2.ZERO
		
		if abs(diff.x) > abs(diff.y): # If closer on y than on x
			if diff.y > 0: # Player below enemy
				move.y = 1
			elif diff.y < 0: # Player above enemy
				move.y = -1
				
			if diff.x > 0:
				move.x = -1
				dir = Vector2.RIGHT
			else:
				move.x = 1
				dir = Vector2.LEFT
		else: # If closer on x than y
			if diff.x > 0:
				
				move.x = 1
			elif diff.x < 0:
				
				move.x = -1
			if diff.y > 0:
				move.y = -1
				dir = Vector2.DOWN
			else:
				move.y = 1
				dir = Vector2.UP

		enemy.velocity = move.normalized() * move_speed


func _on_shoot_timer_timeout() -> void:
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = enemy.global_position
	#var direction = (target.global_position - enemy.global_position).normalized()
	if projectile.has_method("set_direction"):
		projectile.set_direction(dir)
	timer.start()
