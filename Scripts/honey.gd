extends Area2D

@export var item_name: String = "honey"

func _on_body_entered(body):
	if body.name == "Player":
		body.collect_item(item_name)
		queue_free()
