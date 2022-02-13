extends Area2D

signal shoot(bullet, position)

var Bullet = preload("res://Bullet.tscn")

const MOVE_SPEED = 300

onready var _screen_size_x = get_viewport_rect().size.x
onready var _screen_size_y = get_viewport_rect().size.y


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var lr_action = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	var ud_action = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")

	position.x = clamp(position.x - lr_action * MOVE_SPEED * delta, 50, _screen_size_x - 50)
	position.y = clamp(position.y - ud_action * MOVE_SPEED * delta, 50, _screen_size_y - 50)

	if Input.is_action_just_pressed("ui_select"):
		emit_signal("shoot", Bullet, $GunPosition.global_position)
