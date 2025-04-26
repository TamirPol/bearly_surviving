extends Area2D

@export var item_name: String = "flower"
func _ready() -> void:
	var random_flower = randi_range(0,2)
	$Sprite2D.frame = random_flower
func _on_body_entered(body):
	print(body.name)
	if body.name == "Player":
		body.collect_item(item_name)
		queue_free()
