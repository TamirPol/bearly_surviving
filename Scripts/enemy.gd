extends CharacterBody2D

var levels = [
	{
		"health": 1,
		"stutter": 2,
		"sprite": "level0"
	},
	{
		"health": 3,
		"stutter": 4,
		"sprite": "level1"
	},
	{
		"health": 5,
		"stutter": 5,
		"sprite": "level2"
	}]

var current_level = 0
var health: int
var stutter_time: int
var animation: String
func _ready() -> void:
	stat_update()
func stat_update():
	health = levels[current_level]["health"]
	stutter_time = levels[current_level]["stutter"]
	animation = levels[current_level]["sprite"]
func increase_level():
	current_level += 1
	stat_update()
	
func take_damage():
	health -= 1
	if health <= 0:
		queue_free()
		put_seeds()
		return
		
func put_seeds():
	pass
