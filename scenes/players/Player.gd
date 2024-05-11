extends Area2D

signal killed

var Bullet = preload("res://scenes/weapons/Bullet.tscn")

export(NodePath) onready var bullet_container_path  = get_node(bullet_container_path) as Node2D

const MOVE_SPEED = 300

onready var _screen_size_x = get_viewport_rect().size.x
onready var _screen_size_y = get_viewport_rect().size.y


# Called when the node enters the scene tree for the first time.
func _ready():
	$Blaster.bullet_container = bullet_container_path


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var lr_action = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	var ud_action = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")

	position.x = clamp(position.x - lr_action * MOVE_SPEED * delta, 50, _screen_size_x - 50)
	position.y = clamp(position.y - ud_action * MOVE_SPEED * delta, 50, _screen_size_y - 50)

	if Input.is_action_pressed("fire_weapon"):
		shoot()


func hit():
	emit_signal("killed")
	queue_free()


func shoot():
	$Blaster.fire(Vector2($Blaster.global_position.x, $Blaster.global_position.y-1000),  "EnemyGroup")
