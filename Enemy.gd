extends Area2D

signal killed

const MOVE_SPEED = 50

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func hit():
	emit_signal("killed")
	queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position + (Vector2(0, MOVE_SPEED) * delta)


func _on_enemy_viewport_exited(viewport):
	queue_free()
