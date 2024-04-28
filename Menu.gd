extends Control


func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE:
		_on_Exit_pressed()


func _on_Start_pressed():
	get_tree().change_scene("res://Spaceshooter.tscn")


func _on_Exit_pressed():
	get_tree().quit()
