extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE:
		get_tree().quit()


func _on_Start_pressed():
	get_tree().change_scene("res://Spaceshooter.tscn")


func _on_Exit_pressed():
	get_tree().quit()
