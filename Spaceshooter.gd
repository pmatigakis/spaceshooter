extends Node2D

var enemy_scene = preload("res://Enemy.tscn")

onready var _screen_size_x = get_viewport_rect().size.x
onready var _screen_size_y = get_viewport_rect().size.y

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemyTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_EnemyTimer_timeout():
	var enemy_spawn_location = get_node("EnemyPath/EnemySpawnLocation")
	enemy_spawn_location.offset = randi()
	
	var enemy = enemy_scene.instance()
	enemy.rotate(deg2rad(180))
	enemy.position = enemy_spawn_location.position
	enemy.connect("killed", self, "_on_Enemy_killed")
	add_child(enemy)

func _on_Enemy_killed():
	$HUD.increase_score()
