extends Node2D

signal score_changed(new_score)
signal difficulty_changed(new_difficulty)
signal player_killed

const MAX_DIFICULTY = 4
const DIFFICULTY_LEVELS = {
	0: {
		"min_extra_speed": 0,
		"max_extra_speed": 30,
		"spawn_rate": 1.0,
		"extra_fire_rate": 0
	},
	1: {
		"min_extra_speed": 10,
		"max_extra_speed": 30,
		"spawn_rate": 0.9,
		"extra_fire_rate": 1000
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
var explosion_scene = preload("res:///scenes/effects/explosions/Explosion.tscn")

var difficulty = 0
var score = 0

var min_extra_speed = 0
var max_extra_speed = 30

@onready var _screen_size_x = get_viewport_rect().size.x
@onready var _screen_size_y = get_viewport_rect().size.y

var spawn_x_padding = 50
var spawn_y_padding = -50

# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemyTimer.wait_time = DIFFICULTY_LEVELS[difficulty]["spawn_rate"]
	$EnemyTimer.start()
	emit_signal("difficulty_changed", difficulty+1)
	emit_signal("score_changed", score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Menu.tscn")


func _increase_score():
	score += 1
	emit_signal("score_changed", score)


func _increase_difficulty():
	difficulty += 1
	emit_signal("difficulty_changed", difficulty+1)

	$EnemyTimer.wait_time = DIFFICULTY_LEVELS[difficulty]["spawn_rate"]


func _on_EnemyTimer_timeout():
	var enemy = enemy_scene.instantiate()
	enemy.bullet_container = $Bullets
	enemy.position = Vector2(randi_range(spawn_x_padding, _screen_size_x - spawn_x_padding), spawn_y_padding)
	print(enemy.position)
	enemy.speed += randf_range(DIFFICULTY_LEVELS[difficulty]["min_extra_speed"], DIFFICULTY_LEVELS[difficulty]["max_extra_speed"])
	enemy.connect("killed", Callable(self, "_on_Enemy_killed"))
	self.connect("player_killed", Callable(enemy, "_on_Player_killed"))
	$Enemies.add_child(enemy)


func _on_Enemy_killed(enemy):
	var explosion = explosion_scene.instantiate()
	explosion.position = enemy.position
	$Explossions.add_child(explosion)
	
	_increase_score()

	if score % 10 == 0 and difficulty < MAX_DIFICULTY:
		_increase_difficulty()


func _on_Player_killed():
	$EnemyTimer.stop()
	emit_signal("player_killed")

	var explosion = explosion_scene.instantiate()
	explosion.position = $Player.position
	$Explossions.add_child(explosion)
