extends Area2D

signal killed

var Bullet = preload("res://scenes/weapons/Bullet.tscn")

var speed = 50
var shoot = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position + (Vector2(0, speed) * delta)

	if $Blaster.is_ready_to_fire() and shoot:
		var player = get_tree().root.get_node("Spaceshooter/Player")
		if player:
			self._fire(player.position)

	
func _on_enemy_viewport_exited(viewport):
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("PlayerGroup"):
		area.hit()
		queue_free()


func _fire(target_position):
	$Blaster.fire(target_position, "PlayerGroup")


func _on_Player_killed():
	shoot = false


func hit():
	emit_signal("killed")
	queue_free()
