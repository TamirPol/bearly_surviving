extends CharacterBody2D

@export var speed := 80
@onready var anim = $AnimatedSprite2D
@export var inventory = {
	"berry": 0,
	"flower": 0,
	"honey": 0,
	"seeds": 0
}
var facing_direction : String = "backward"
var can_attack = true
var is_attacking = false
var iframe = false

@export var allowed = true
@export var sword = null

func _ready() -> void:
	sword = $"Sword Swing"

func _physics_process(_delta: float) -> void:
	if allowed:
		var moving = false
		var dir = Vector2.ZERO
		if Input.is_action_pressed("down"):
			dir.y += 1
			moving = true
			facing_direction = "backward"
		if Input.is_action_pressed("up"):
			dir.y -= 1
			moving = true
			facing_direction = "forward"
		if Input.is_action_pressed("left"):
			dir.x -= 1
			moving = true
			facing_direction = "left"
		if Input.is_action_pressed("right"):
			dir.x += 1
			moving = true 
			facing_direction = "right"
		velocity = dir.normalized() * speed
		move_and_slide()
		update_animation(moving)
		if Input.is_action_just_pressed("attack") and can_attack:
			attack()
			
	
func update_animation(moving):
	if is_attacking: return
	if moving: anim.animation = "walk_%s" % facing_direction
	else: anim.animation = "idle_%s" % facing_direction
	anim.play()
func attack():
	can_attack = false
	is_attacking = true
	anim.animation = "attack_%s" % facing_direction
	anim.play()

	$attack_animation.start()


func _on_sword_swing_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.take_damage()

func _on_attack_cooldown_timeout() -> void:
	can_attack = true


func _on_attack_length_timeout() -> void:
	sword.monitoring = false
	
func return_inventory():
	var copy = inventory
	copy.erase("seeds")
	return copy
signal player_collected
func collect_item(item):
	inventory[item] += 1
	emit_signal("player_collected")

func stutter():
	if !allowed or iframe: return
	allowed = false
	$stutter_timer.start()
func _on_attack_animation_timeout() -> void:
	is_attacking = false
	sword.monitoring = true
	$attack_length.start()
	$attack_cooldown.start()


func _on_stutter_timer_timeout() -> void:
	allowed = true
	iframe = true
	$iframe_timer.start()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		stutter()


func _on_iframe_timer_timeout() -> void:
	iframe = false
