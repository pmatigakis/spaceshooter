extends Node2D


var Bullet = preload("res://scenes/weapons/Bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func is_ready_to_fire():
	return $ReloadTimer.is_stopped()


func fire(target_position):
	if is_ready_to_fire():
		var bullet = Bullet.instance()
		bullet.position = global_position
		bullet.start(global_position.direction_to(target_position) * 200, "PlayerGroup")
		
		var bullet_container = get_tree().root.get_node("Spaceshooter/Bullets")
		bullet_container.add_child(bullet)

		$ReloadTimer.start()
