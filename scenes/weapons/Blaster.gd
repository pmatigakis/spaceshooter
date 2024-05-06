extends Node2D


export var fire_rate = 2.0
export var bullet_speed = 200.0



var Bullet = preload("res://scenes/weapons/Bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	set_fire_rate(fire_rate)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func is_ready_to_fire():
	return $ReloadTimer.is_stopped()


func fire(target_position, target_group):
	if is_ready_to_fire():
		var bullet = Bullet.instance()
		bullet.position = global_position
		bullet.start(global_position.direction_to(target_position) * bullet_speed, target_group)
		
		var bullet_container = get_tree().root.get_node("Spaceshooter/Bullets")
		bullet_container.add_child(bullet)

		$FireSound.play()
		$ReloadTimer.start()


func set_fire_rate(fire_rate):
	self.fire_rate = fire_rate
	$ReloadTimer.wait_time = fire_rate
