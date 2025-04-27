extends Area2D

var direction = Vector2.ZERO
@export var speed = 200.0

func set_direction(dir: Vector2):
	direction = dir

func _physics_process(delta):
	position += direction * speed * delta
