extends CharacterBody2D

@export var speed := 150
#@onready var anim = $AnimatedSprite2d
@export var inventory = {
	"berry": 0,
	"flower": 0,
	"honey": 0,
	"seeds": 0
}
var facing_direction := Vector2.UP
var can_attack = true
@export var allowed = true
@export var sword = null
func _ready() -> void:
	sword = $"Sword Swing"

func _physics_process(_delta: float) -> void:
	if allowed:
		var dir = Vector2.ZERO
		if Input.is_action_pressed("down"):
			dir.y += 1
		if Input.is_action_pressed("up"):
			dir.y -= 1
		if Input.is_action_pressed("left"):
			dir.x -= 1
		if Input.is_action_pressed("right"):
			dir.x += 1 
		velocity = dir.normalized() * speed
		move_and_slide()
	if Input.is_action_just_pressed("attack") and can_attack:
		attack()

func attack():
	can_attack = false
	sword.monitoring = true
	$attack_length.start()
	$attack_cooldown.start()


func _on_sword_swing_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.take_damage()

func _on_attack_cooldown_timeout() -> void:
	can_attack = true


func _on_attack_length_timeout() -> void:
	sword.monitoring = false

func collect_item(item):
	inventory[item] += 1
	print(inventory)
