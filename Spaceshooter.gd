extends Node2D

var enemy_scene = preload("res://Enemy.tscn")

onready var _screen_size_x = get_viewport_rect().size.x
onready var _screen_size_y = get_viewport_rect().size.y

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(10):
		var enemy = enemy_scene.instance()
		enemy.rotate(deg2rad(180))
		enemy.start(100, _screen_size_x-100, -rand_range(100, 100 + _screen_size_y * 0.5))
		add_child(enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
