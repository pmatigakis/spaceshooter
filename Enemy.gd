extends Area2D

signal killed
signal shoot(bullet, position)

var Bullet = preload("res://Bullet.tscn")

var speed = 50

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
	position = position + (Vector2(0, speed) * delta)


func _on_enemy_viewport_exited(viewport):
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("PlayerGroup"):
		area.hit()
		queue_free()


func _on_ShootingTimer_timeout():
	emit_signal("shoot", Bullet, position)


func start_shooting():
	$ShootingTimer.start()


func stop_shooting():
	$ShootingTimer.stop()
