extends Node2D

@export var berry_scene: PackedScene
@export var flower_scene: PackedScene
@export var honey_scene: PackedScene
@export var spawn_area: Rect2

@export var total_resources = 10
var resources = {
	"berry": 0,
	"flower": 0,
	"honey": 0
}
var used_positions: Array = []
func spawn_items():
	var berry_amount = randi_range(2, 8)
	var flower_amount = randi_range(2, 8-berry_amount)
	var honey_amount = 10-berry_amount-flower_amount
	for i in berry_amount:
		spawn_item(berry_scene, "berry")
	for i in flower_amount:
		spawn_item(flower_scene, "flower")
	for i in honey_amount:
		spawn_item(honey_scene, "honey")
	return resources

func spawn_item(scene: PackedScene, name: String):	
	var max_attempts = 10
	var found_spot = false
	var random_pos = Vector2.ZERO
	
	while not found_spot and max_attempts > 0:
		random_pos = Vector2(
			randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x),
			randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
		)

		found_spot = true
		for pos in used_positions:
			if pos.distance_to(random_pos) < 30:
				found_spot = false
				break

		max_attempts -= 1
	
	if found_spot:
		var item_instance = scene.instantiate()
		item_instance.global_position = random_pos
		add_child(item_instance)
		used_positions.append(random_pos)
		resources[name] += 1
	else:
		print("Failed to find non-overlapping position for item.")
