extends State
class_name Attack

@export var enemy : CharacterBody2D
@export var move_speed : float = 100.0
var target

func Enter():
	target = get_tree().get_first_node_in_group("player")

func Update(delta: float) -> void:
	pass

func Physics_Update(_delta: float) -> void:
	if enemy and target:
		var enemy_pos = enemy.global_position
		var target_pos = target.global_position
		var diff = target_pos - enemy_pos

		var move = Vector2.ZERO

		if abs(diff.x) < abs(diff.y):
			if diff.x > 0:
				move.x = -1
			else:
				move.x = 1

			if diff.y > 0:
				move.y = 1
			else:
				move.y = -1
		else:
			if diff.y > 0:
				move.y = -1
			else:
				move.y = 1

			if diff.x > 0:
				move.x = 1
			else:
				move.x = -1
		
		if abs(diff.x) < abs(diff.y):
			move.x = move.x
			move.y = 0
		else:
			move.y = move.y
			move.x = 0

		enemy.velocity = move.normalized() * move_speed
