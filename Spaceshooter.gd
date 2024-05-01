extends Node2D

const MAX_DIFICULTY = 4
const DIFFICULTY_LEVELS = {
	0: {
		"min_extra_speed": 0,
		"max_extra_speed": 30,
		"spawn_rate": 1.0
	},
	1: {
		"min_extra_speed": 10,
		"max_extra_speed": 30,
		"spawn_rate": 0.9
	},
	2: {
		"min_extra_speed": 20,
		"max_extra_speed": 30,
		"spawn_rate": 0.8
	},
	3: {
		"min_extra_speed": 30,
		"max_extra_speed": 40,
		"spawn_rate": 0.7
	},
	4: {
		"min_extra_speed": 40,
		"max_extra_speed": 50,
		"spawn_rate": 0.6
	}
}

var enemy_scene = preload("res:///scenes/enemies/Enemy.tscn")

var current_difficulty = 0
var min_extra_speed = 0
var max_extra_speed = 30

onready var _screen_size_x = get_viewport_rect().size.x
onready var _screen_size_y = get_viewport_rect().size.y

# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemyTimer.wait_time = DIFFICULTY_LEVELS[current_difficulty]["spawn_rate"]
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
	enemy.speed += rand_range(DIFFICULTY_LEVELS[current_difficulty]["min_extra_speed"], DIFFICULTY_LEVELS[current_difficulty]["max_extra_speed"])
	enemy.connect("killed", self, "_on_Enemy_killed")
	$Enemies.add_child(enemy)


func _on_Enemy_killed():
	$HUD.increase_score()
	if $HUD.score % 10 == 0 and current_difficulty < MAX_DIFICULTY:
		current_difficulty += 1
		$EnemyTimer.wait_time = DIFFICULTY_LEVELS[current_difficulty]["spawn_rate"]
		$HUD.increase_difficulty()


func _on_Player_killed():
	$EnemyTimer.stop()
	get_tree().call_group("EnemyGroup", "stop_shooting")
	$HUD.show_message("You died!")
