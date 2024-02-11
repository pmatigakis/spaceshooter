extends Node2D

var enemy_scene = preload("res://Enemy.tscn")

onready var _screen_size_x = get_viewport_rect().size.x
onready var _screen_size_y = get_viewport_rect().size.y


# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemyTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE:
		get_tree().change_scene("res://Menu.tscn")


func _on_EnemyTimer_timeout():
	var enemy_spawn_location = get_node("EnemyPath/EnemySpawnLocation")
	enemy_spawn_location.offset = randi()
	
	var enemy = enemy_scene.instance()
	enemy.position = enemy_spawn_location.position
	enemy.speed += rand_range(0, 30)
	enemy.connect("killed", self, "_on_Enemy_killed")
	$Enemies.add_child(enemy)


func _on_Enemy_killed():
	$HUD.increase_score()


func _on_Player_shoot(bullet):
	$Bullets.add_child(bullet)


func _on_Player_killed():
	$EnemyTimer.stop()
	get_tree().call_group("EnemyGroup", "stop_shooting")
	$HUD.show_message("You died!")
