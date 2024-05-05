extends Control


func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		_on_Exit_pressed()


func _on_Start_pressed():
	get_tree().change_scene("res://Spaceshooter.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_Controls_pressed():
	get_tree().change_scene("res://scenes/settings/controls/Controls.tscn")
