extends Node2D
var need_to_collect = {}
func _ready() -> void:
	new_day()
	

func new_day():
	need_to_collect = $"Spawn Manager".spawn_items()
	#Spawn vines as needed
	$Player.position = Vector2i(128, 63)

func did_player_collect():
	if $Player.return_inventory() == need_to_collect:
		pass
	else:
		print("WOOW")


func _on_player_player_collected() -> void:
	did_player_collect()
