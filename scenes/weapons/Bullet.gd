extends Area2D

var velocity
var target_group


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	position = position + velocity * delta


func _on_Bullet_viewport_exited(viewport):
	queue_free()


func _on_area_entered(area):
	if area.is_in_group(target_group) and area.has_method("hit"):
		area.hit()
		queue_free()


func start(velocity, target_group):
	self.velocity = velocity
	self.target_group = target_group
