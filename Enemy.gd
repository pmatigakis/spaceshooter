extends Area2D


const MOVE_SPEED = 50
var spawn_start_x
var spawn_end_x
var y_start

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(spawn_start_x, spawn_end_x, y_start):
	self.spawn_start_x = spawn_start_x
	self.spawn_end_x = spawn_end_x
	self.y_start = y_start
	reset()

func reset():
	position.x = rand_range(spawn_start_x, spawn_end_x)
	position.y = y_start

func die():
	reset()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position + (Vector2(0, MOVE_SPEED) * delta)


func _on_enemy_viewport_exited(viewport):
	reset()
