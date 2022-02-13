extends Area2D

var velocity
var target

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(velocity, target):
	self.velocity = velocity
	self.target = target

func _process(delta):
	position = position + velocity * delta

func _on_Bullet_viewport_exited(viewport):
	queue_free()

func _on_area_entered(area):
	if area.is_in_group(target):
		if area.has_method("hit"):
			area.hit()
			queue_free()
